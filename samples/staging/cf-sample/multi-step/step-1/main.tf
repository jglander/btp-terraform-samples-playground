###############################################################################################
# Setup subaccount domain and the CF org (to ensure uniqueness in BTP global account)
###############################################################################################
locals {
  random_uuid = uuid()
  project_subaccount_domain = "my-sa-${local.random_uuid}"
  #project_subaccount_cf_org = substr(replace("${local.project_subaccount_domain}", "-", ""),0,32)
  custom_idp_tenant = var.custom_idp != "" ? element(split(".", var.custom_idp), 0) : ""
  custom_idp_origin = local.custom_idp_tenant != "" ? "${local.custom_idp_tenant}-platform" : ""
}

###############################################################################################
# Create subaccount
###############################################################################################
resource "btp_subaccount" "project" {
  name      = var.subaccount_name
  subdomain = local.project_subaccount_domain
  region    = lower(var.region)
  usage = "USED_FOR_PRODUCTION"
}

data "btp_subaccount" "project" {
  id = btp_subaccount.project.id
}

######################################################################
# Get all available environments for the subaccount
######################################################################
data "btp_subaccount_environments" "all" {
  subaccount_id = btp_subaccount.project.id
}

data "btp_subaccount_trust_configurations" "all" {
  subaccount_id = btp_subaccount.project.id
}

######################################################################
# Extract list of CF landscape labels from environments
######################################################################
locals {
  cf_landscape_labels = [
    for env in data.btp_subaccount_environments.all.values : env.landscape_label
    if env.environment_type == "cloudfoundry"
  ]
}

######################################################################
# Create Cloud Foundry environment
######################################################################
resource "btp_subaccount_environment_instance" "cloudfoundry" {
  subaccount_id    = btp_subaccount.project.id
  name             = "my-cf-environment"
  # pick the first CF landscape label
  landscape_label  = local.cf_landscape_labels[0]
  environment_type = "cloudfoundry"
  service_name     = "cloudfoundry"
  plan_name        = "standard"
  parameters = jsonencode({
    instance_name = var.cf_org_name
  })
}

# ------------------------------------------------------------------------------------------------------
# Create tfvars file for step 2 (if variable `create_tfvars_file_for_step2` is set to true)
# ------------------------------------------------------------------------------------------------------
resource "local_file" "output_vars_step1" {
  count    = var.create_tfvars_file_for_step2 ? 1 : 0
  content  = <<-EOT
      globalaccount        = "${var.globalaccount}"
      cli_server_url       = ${jsonencode(var.cli_server_url)}

      subaccount_id        = "${data.btp_subaccount.project.id}"

      cf_api_url           = "${jsondecode(btp_subaccount_environment_instance.cloudfoundry.labels)["API Endpoint"]}"

      cf_org_id            = "${jsondecode(btp_subaccount_environment_instance.cloudfoundry.labels)["Org ID"]}"

      cf_landscape_label   = "${local.cf_landscape_labels[0]}"

      EOT
  filename = "../step-2/terraform.tfvars"
}
