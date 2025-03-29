# ------------------------------------------------------------------------------------------------------
# Subaccount setup for DC mission 3585_trial
# ------------------------------------------------------------------------------------------------------
# Setup subaccount domain (to ensure uniqueness in BTP global account)
resource "random_uuid" "uuid" {}

# ------------------------------------------------------------------------------------------------------
# Creation of subaccount
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount" "dc_mission" {
  count     = var.subaccount_id == "" ? 1 : 0
  name      = var.subaccount_name
  subdomain = join("-", ["dc-mission-3585", random_uuid.uuid.result])
  region    = lower(var.region)
}

data "btp_subaccount" "dc_mission" {
  id = var.subaccount_id != "" ? var.subaccount_id : btp_subaccount.dc_mission[0].id
}

# ------------------------------------------------------------------------------------------------------
# SERVICES
# ------------------------------------------------------------------------------------------------------
locals {
  # optional, if custom idp is used
  service_name__sap_identity_services_onboarding  = "sap-identity-services-onboarding"
}

# ------------------------------------------------------------------------------------------------------
# Setup sap-identity-services-onboarding (Cloud Identity Services)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "sap_identity_services_onboarding" {
  count         = var.custom_idp == "" ? 1 : 0

  subaccount_id = data.btp_subaccount.dc_mission.id
  service_name  = local.service_name__sap_identity_services_onboarding
  plan_name     = var.service_plan__sap_identity_services_onboarding
}
# Subscribe
resource "btp_subaccount_subscription" "sap_identity_services_onboarding" {
  count = var.custom_idp == "" ? 1 : 0

  subaccount_id = data.btp_subaccount.dc_mission.id
  app_name      = local.service_name__sap_identity_services_onboarding
  plan_name     = var.service_plan__sap_identity_services_onboarding
}
# IdP trust configuration
resource "btp_subaccount_trust_configuration" "fully_customized" {
  subaccount_id     = data.btp_subaccount.dc_mission.id
  identity_provider = var.custom_idp != "" ? var.custom_idp : element(split("/", btp_subaccount_subscription.sap_identity_services_onboarding[0].subscription_url), 2)
}

# ------------------------------------------------------------------------------------------------------
# APP SUBSCRIPTIONS
# ------------------------------------------------------------------------------------------------------
#
locals {
  service_name__sap_launchpad = "SAPLaunchpad"
}
# ------------------------------------------------------------------------------------------------------
# Setup SAPLaunchpad (SAP Build Work Zone, standard edition)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "sap_launchpad" {
  subaccount_id = data.btp_subaccount.dc_mission.id
  service_name  = local.service_name__sap_launchpad
  plan_name     = var.service_plan__sap_launchpad
}

# ------------------------------------------------------------------------------------------------------
#  USERS AND ROLES
# ------------------------------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------------------------------
# Assign role collection "Subaccount Administrator"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "subaccount_admin" {
  for_each             = toset("${var.subaccount_admins}")
  subaccount_id        = data.btp_subaccount.dc_mission.id
  role_collection_name = "Subaccount Administrator"
  user_name            = each.value
  depends_on           = [btp_subaccount.dc_mission]
}

# ------------------------------------------------------------------------------------------------------
# Create tfvars file for step 2 (if variable `create_tfvars_file_for_step2` is set to true)
# ------------------------------------------------------------------------------------------------------
resource "local_file" "output_vars_step1" {
  count    = var.create_tfvars_file_for_step2 ? 1 : 0
  content  = <<-EOT
      globalaccount        = "${var.globalaccount}"
      cli_server_url       = ${jsonencode(var.cli_server_url)}
      custom_idp           = "${var.custom_idp}"

      subaccount_id        = "${data.btp_subaccount.dc_mission.id}"

      launchpad_admins     = ${jsonencode(var.launchpad_admins)}

      EOT
  filename = "../step2/terraform.tfvars"
}