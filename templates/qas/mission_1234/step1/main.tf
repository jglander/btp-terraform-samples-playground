# ------------------------------------------------------------------------------------------------------
# Subaccount setup for DC mission 1234
# ------------------------------------------------------------------------------------------------------
# Setup subaccount domain (to ensure uniqueness in BTP global account)
resource "random_uuid" "uuid" {}

locals {
  random_uuid       = random_uuid.uuid.result
  timestamp         = formatdate("YYYYMMDDhhmmss", timestamp())
  subaccount_domain = "dcmission1234${local.random_uuid}"
  subaccount_name   = var.subaccount_name == "" ? "SAP Discovery Center Mission 1234 - ${local.timestamp}" : var.subaccount_name
}

# Creation of subaccount
resource "btp_subaccount" "dc_mission" {
  count = var.subaccount_id == "" ? 1 : 0

  name      = local.subaccount_name
  subdomain = local.subaccount_domain
  region    = var.region
}

data "btp_subaccount" "dc_mission" {
  id = var.subaccount_id != "" ? var.subaccount_id : btp_subaccount.dc_mission[0].id
}

# Assign custom IDP to sub account (if custom_idp is set)
resource "btp_subaccount_trust_configuration" "fully_customized" {
  # Only create trust configuration if custom_idp has been set 
  count             = var.custom_idp == "" ? 0 : 1
  subaccount_id     = data.btp_subaccount.dc_mission.id
  identity_provider = var.custom_idp
}

data "btp_whoami" "me" {}

locals {
  origin_key = data.btp_whoami.me.issuer != var.custom_idp ? "sap.default" : "${element(split(".", var.custom_idp), 0)}-platform"
}

# Assign role collection "Subaccount Administrator"
resource "btp_subaccount_role_collection_assignment" "subaccount_admin" {
  for_each             = toset("${var.subaccount_admins}")
  subaccount_id        = data.btp_subaccount.dc_mission.id
  role_collection_name = "Subaccount Administrator"
  user_name            = each.value
  origin               = local.origin_key
  depends_on           = [btp_subaccount.dc_mission]
}

# Assign role collection "Subaccount Service Administrator"
resource "btp_subaccount_role_collection_assignment" "subaccount_service_admin" {
  for_each             = toset("${var.subaccount_service_admins}")
  subaccount_id        = data.btp_subaccount.dc_mission.id
  role_collection_name = "Subaccount Service Administrator"
  user_name            = each.value
  origin               = local.origin_key
  depends_on           = [btp_subaccount.dc_mission]
}

# ------------------------------------------------------------------------------------------------------
# ENVIRONMENTS
# ------------------------------------------------------------------------------------------------------
locals {
  service_env_name__cloudfoundry = "cloudfoundry"
}

# ------------------------------------------------------------------------------------------------------
# Setup cloudfoundry (Cloud Foundry Environment)
# ------------------------------------------------------------------------------------------------------
#
# Fetch all available environments for the subaccount
data "btp_subaccount_environments" "all" {
  subaccount_id = data.btp_subaccount.dc_mission.id
}
# Take the landscape label from the first CF environment if no environment label is provided (this replaces the previous null_resource)
resource "terraform_data" "cf_landscape_label" {
  input = length(var.cf_landscape_label) > 0 ? var.cf_landscape_label : [for env in data.btp_subaccount_environments.all.values : env if env.service_name == "cloudfoundry" && env.environment_type == "cloudfoundry"][0].landscape_label
}
# Create instance
locals {
  cf_org_name   = var.cf_org_name == "" ? "cf_org_name_dcmission_1234_${local.random_uuid}" : var.cf_org_name
}
resource "btp_subaccount_environment_instance" "cloudfoundry" {
  subaccount_id    = data.btp_subaccount.dc_mission.id
  name             = local.cf_org_name
  environment_type = "cloudfoundry"
  service_name     = local.service_env_name__cloudfoundry
  plan_name        = var.service_env_plan__cloudfoundry
  landscape_label  = terraform_data.cf_landscape_label.output

  parameters = jsonencode({
    instance_name = local.cf_org_name
  })
}

# ------------------------------------------------------------------------------------------------------
# SERVICES
# ------------------------------------------------------------------------------------------------------
#
locals {
  service_name__sap_analytics_cloud = "analytics-planning-osb"
}

# ------------------------------------------------------------------------------------------------------
# Setup SAP Analytics Cloud (not running in CF environment)
# ------------------------------------------------------------------------------------------------------
# Entitle 
resource "btp_subaccount_entitlement" "sac" {
  count         = var.is_service_setup_enabled__sac ? 1 : 0
  subaccount_id = data.btp_subaccount.dc_mission.id
  service_name  = local.service_name__sap_analytics_cloud
  plan_name     = var.service_plan__sap_analytics_cloud
}

# Get serviceplan_id for data-analytics-osb with plan_name "standard"
data "btp_subaccount_service_plan" "sac" {
  count         = var.is_service_setup_enabled__sac ? 1 : 0
  subaccount_id = data.btp_subaccount.dc_mission.id
  offering_name = local.service_name__sap_analytics_cloud
  name          = var.service_plan__sap_analytics_cloud
  depends_on    = [btp_subaccount_entitlement.sac]
}

# Create service instance
resource "btp_subaccount_service_instance" "sac" {
  count         = var.is_service_setup_enabled__sac ? 1 : 0
  subaccount_id  = data.btp_subaccount.dc_mission.id
  serviceplan_id = data.btp_subaccount_service_plan.sac[0].id
  name           = "sac_instance"
  parameters = jsonencode(
    {
      "first_name" : "${var.sac_admin_first_name}",
      "last_name" : "${var.sac_admin_last_name}",
      "email" : "${var.sac_admin_email}",
      "confirm_email" : "${var.sac_admin_email}",
      "host_name" : "${var.sac_admin_host_name}",
      "number_of_business_intelligence_licenses" : var.sac_number_of_business_intelligence_licenses,
      "number_of_planning_professional_licenses" : var.sac_number_of_professional_licenses,
      "number_of_planning_standard_licenses" : var.sac_number_of_business_standard_licenses
    }
  )
  timeouts = {
    create = "90m"
    update = "90m"
    delete = "90m"
  }
}

# ------------------------------------------------------------------------------------------------------
# APP SUBSCRIPTIONS
# ------------------------------------------------------------------------------------------------------
#
locals {
  # optional
  app_subscription_serv_name__sap_launchpad = "SAPLaunchpad"
}

# ------------------------------------------------------------------------------------------------------
# Setup SAPLaunchpad (SAP Build Work Zone, standard edition)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "sap_launchpad" {
  count         = var.use_optional_resources && var.is_service_setup_enabled__sap_launchpad ? 1 : 0
  subaccount_id = btp_subaccount.dc_mission[0].id
  service_name  = local.app_subscription_serv_name__sap_launchpad
  plan_name     = var.app_subscription_plan__sap_launchpad
  amount        = var.app_subscription_plan__sap_launchpad == "free" ? 1 : null
}

# Subscribe
resource "btp_subaccount_subscription" "sap_launchpad" {
  count         = var.use_optional_resources && var.is_service_setup_enabled__sap_launchpad ? 1 : 0
  subaccount_id = btp_subaccount.dc_mission[0].id
  app_name      = local.app_subscription_serv_name__sap_launchpad
  plan_name     = var.app_subscription_plan__sap_launchpad
  depends_on    = [btp_subaccount_entitlement.sap_launchpad]
}

# Assign role collection "Launchpad_Admin"
resource "btp_subaccount_role_collection_assignment" "launchpad_admin" {
  for_each             = toset(var.use_optional_resources == true && var.is_service_setup_enabled__sap_launchpad == true ? var.launchpad_admins : [])
  subaccount_id        = btp_subaccount.dc_mission[0].id
  role_collection_name = "Launchpad_Admin"
  user_name            = each.value
  origin               = local.origin_key
  depends_on           = [btp_subaccount_subscription.sap_launchpad]
}

# ------------------------------------------------------------------------------------------------------
# Create tfvars file for step 2 (if variable `create_tfvars_file_for_step2` is set to true)
# ------------------------------------------------------------------------------------------------------
resource "local_file" "output_vars_step1" {
  count    = var.create_tfvars_file_for_step2 ? 1 : 0
  content  = <<-EOT
      globalaccount        = "${var.globalaccount}"
      cli_server_url       = ${jsonencode(var.cli_server_url)}
      custom_idp           = ${jsonencode(var.custom_idp)}

      subaccount_id        = "${data.btp_subaccount.dc_mission.id}"

      cf_api_url           = "${jsondecode(btp_subaccount_environment_instance.cloudfoundry.labels)["API Endpoint"]}"
      cf_org_id            = "${jsondecode(btp_subaccount_environment_instance.cloudfoundry.labels)["Org ID"]}"
      cf_space_name        = "${var.cf_space_name}"

      cf_org_managers      = ${jsonencode(var.cf_org_managers)}
      cf_org_users         = ${jsonencode(var.cf_org_users)}
      cf_space_developers  = ${jsonencode(var.cf_space_developers)}
      cf_space_managers    = ${jsonencode(var.cf_space_managers)}

      EOT
  filename = "../step2/terraform.tfvars"
}