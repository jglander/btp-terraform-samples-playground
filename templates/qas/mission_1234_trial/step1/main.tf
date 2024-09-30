# ------------------------------------------------------------------------------------------------------
# Subaccount setup for DC mission <1234> (trial)
# ------------------------------------------------------------------------------------------------------
# Setup subaccount domain (to ensure uniqueness in BTP global account)
resource "random_uuid" "uuid" {}

locals {
  random_uuid       = random_uuid.uuid.result
  subaccount_domain = "dcmission1234${local.random_uuid}"
}

# ------------------------------------------------------------------------------------------------------
# Creation of subaccount
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount" "dc_mission" {
  count = var.subaccount_id == "" ? 1 : 0

  name      = var.subaccount_name
  subdomain = local.subaccount_domain
  region    = var.region
}

data "btp_subaccount" "dc_mission" {
  id = var.subaccount_id != "" ? var.subaccount_id : btp_subaccount.dc_mission[0].id
}
/*
data "btp_subaccount" "subaccount" {
  id = data.btp_subaccount.dc_mission.id
}
*/
# ------------------------------------------------------------------------------------------------------
# ENVIRONMENTS
# ------------------------------------------------------------------------------------------------------
locals {
  service_env_name__cloudfoundry = "cloudfoundry"
}

# ------------------------------------------------------------------------------------------------------
# Setup cloudfoundry (Cloud Foundry Environment)
# ------------------------------------------------------------------------------------------------------
# Fetch all available environments for the subaccount
data "btp_subaccount_environment_instances" "all" {
  subaccount_id = data.btp_subaccount.dc_mission.id
}

# find out if cf environment is already enabled (default in trial subaccount) and if cf space should (|| must) be created
locals {
  cf_org_name      = join("_", [var.globalaccount, data.btp_subaccount.dc_mission.subdomain])
  cf_env_instances = [for env in data.btp_subaccount_environment_instances.all.values : env if env.service_name == "cloudfoundry" && env.environment_type == "cloudfoundry"]
  cf_env_enabled   = length(local.cf_env_instances) > 0
  create_cf_space  = var.create_cf_space || !local.cf_env_enabled
}

# Instance creation (optional)
resource "btp_subaccount_environment_instance" "cloudfoundry" {
  count            = local.cf_env_enabled ? 0 : 1
  subaccount_id    = data.btp_subaccount.dc_mission.id
  name             = local.cf_org_name
  environment_type = "cloudfoundry"
  service_name     = local.service_env_name__cloudfoundry
  plan_name        = var.service_env_plan__cloudfoundry

  parameters = jsonencode({
    instance_name = local.cf_org_name
  })
}

locals {
  cf_env_instance = local.cf_env_enabled ? local.cf_env_instances[0] : btp_subaccount_environment_instance.cloudfoundry[0]
}

# ------------------------------------------------------------------------------------------------------
# SERVICES
# ------------------------------------------------------------------------------------------------------
#
locals {
  service_name__abap_trial   = "abap-trial"
}

/*
# ------------------------------------------------------------------------------------------------------
# Setup abap-trial (ABAP environment)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "abap_trial" {
  subaccount_id = data.btp_subaccount.dc_mission.id
  service_name  = local.service_name__abap_trial
  plan_name     = var.service_plan__abap_trial
  amount        = 1
}
*/

# ------------------------------------------------------------------------------------------------------
# APP SUBSCRIPTIONS
# ------------------------------------------------------------------------------------------------------
#
locals {
  app_subscription_serv_name__sap_launchpad = "SAPLaunchpad"
  # optional
  app_subscription_serv_name__cicd_app          = "cicd-app"
  app_subscription_serv_name__sapappstudiotrial = "sapappstudiotrial"
}

/*
# ------------------------------------------------------------------------------------------------------
# Setup SAPLaunchpad (SAP Build Work Zone, standard edition)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "sap_launchpad" {
  subaccount_id = data.btp_subaccount.dc_mission.id
  service_name  = local.app_subscription_serv_name__sap_launchpad
  plan_name     = var.app_subscription_plan__sap_launchpad
  amount        = var.app_subscription_plan__sap_launchpad == "free" ? 1 : null
}
# Subscribe
resource "btp_subaccount_subscription" "sap_launchpad" {
  subaccount_id = data.btp_subaccount.dc_mission.id
  app_name      = local.app_subscription_serv_name__sap_launchpad
  plan_name     = var.app_subscription_plan__sap_launchpad
  depends_on    = [btp_subaccount_entitlement.sap_launchpad]
}
data "btp_subaccount_subscription" "sap_launchpad" {
  subaccount_id = data.btp_subaccount.dc_mission.id
  app_name      = local.app_subscription_serv_name__sap_launchpad
  plan_name     = var.app_subscription_plan__sap_launchpad
  depends_on    = [btp_subaccount_subscription.sap_launchpad]
}
*/

/*
# ------------------------------------------------------------------------------------------------------
# Setup cicd-app (Continuous Integration & Delivery)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "cicd_app" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id = data.btp_subaccount.dc_mission.id
  service_name  = local.app_subscription_serv_name__cicd_app
  plan_name     = var.app_subscription_plan__cicd_app
  amount        = var.app_subscription_plan__cicd_app == "trial" ? 1 : null
}
# Subscribe
resource "btp_subaccount_subscription" "cicd_app" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id = data.btp_subaccount.dc_mission.id
  app_name      = local.app_subscription_serv_name__cicd_app
  plan_name     = var.app_subscription_plan__cicd_app
  depends_on    = [btp_subaccount_entitlement.cicd_app]
}
*/

/*
# ------------------------------------------------------------------------------------------------------
# Setup sapappstudiotrial (SAP Business Application Studio)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "sapappstudiotrial" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id = data.btp_subaccount.dc_mission.id
  service_name  = local.app_subscription_serv_name__sapappstudiotrial
  plan_name     = var.app_subscription_plan__sapappstudiotrial
}
# Subscribe
resource "btp_subaccount_subscription" "sapappstudiotrial" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id = data.btp_subaccount.dc_mission.id
  app_name      = local.app_subscription_serv_name__sapappstudiotrial
  plan_name     = var.app_subscription_plan__sapappstudiotrial
  depends_on    = [btp_subaccount_entitlement.sapappstudiotrial]
}
*/

# ------------------------------------------------------------------------------------------------------
# Create tfvars file for step 2 (if variable `create_tfvars_file_for_step2` is set to true)
# ------------------------------------------------------------------------------------------------------
resource "local_file" "output_vars_step1" {
  count    = var.create_tfvars_file_for_step2 ? 1 : 0
  content  = <<-EOT
      globalaccount        = "${var.globalaccount}"
      cli_server_url       = ${jsonencode(var.cli_server_url)}

      abap_admin_email    = "${var.abap_admin_email}"

      cf_api_url          = "${jsondecode(local.cf_env_instance.labels)["API Endpoint"]}"
      cf_org_id           = "${local.cf_env_instance.platform_id}"

      create_cf_space     = ${local.create_cf_space}
      cf_space_name       = "${var.cf_space_name}"

      cf_org_managers     = ${jsonencode(var.cf_org_managers)}
      cf_org_users        = ${jsonencode(var.cf_org_users)}
      cf_space_developers = ${jsonencode(var.cf_space_developers)}
      cf_space_managers   = ${jsonencode(var.cf_space_managers)}

      EOT
  filename = "../step2/terraform.tfvars"
}
