# ------------------------------------------------------------------------------------------------------
# Import custom trust config and disable for user login
# ------------------------------------------------------------------------------------------------------
import {
  to = btp_subaccount_trust_configuration.default
  id = "${var.subaccount_id},sap.default"
}

resource "btp_subaccount_trust_configuration" "default" {
  subaccount_id            = var.subaccount_id
  identity_provider        = ""
  auto_create_shadow_users = false
  available_for_user_logon = false
}

# ------------------------------------------------------------------------------------------------------
# SUBSCRIPTIONS
# ------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------
# Subscribe sap-build-apps (SAP Build Apps)
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_subscription" "sap-build-apps" {
  subaccount_id = var.subaccount_id
  app_name      = "sap-appgyver-ee"
  plan_name     = "free"
  depends_on    = [btp_subaccount_trust_configuration.default]
}

# ------------------------------------------------------------------------------------------------------
# Subscribe SAPLaunchpadSMS (SAP Build Work Zone, standard edition)
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_subscription" "sap_launchpad" {
  subaccount_id = var.subaccount_id
  app_name      = "SAPLaunchpadSMS"
  plan_name     = "standard"
}

# ------------------------------------------------------------------------------------------------------
#  USERS AND ROLES
# ------------------------------------------------------------------------------------------------------
#
# Get all roles in the subaccount
data "btp_subaccount_roles" "all" {
  subaccount_id = var.subaccount_id
  depends_on    = [btp_subaccount_subscription.sap-build-apps]
}

# ------------------------------------------------------------------------------------------------------
# Create/Assign role collection "BuildApps_Administrator"
# ------------------------------------------------------------------------------------------------------
# Create
resource "btp_subaccount_role_collection" "build_apps_admin" {
  subaccount_id = var.subaccount_id
  name          = "BuildApps_Administrator"

  roles = [
    for role in data.btp_subaccount_roles.all.values : {
      name                 = role.name
      role_template_app_id = role.app_id
      role_template_name   = role.role_template_name
    } if contains(["BuildApps_Administrator"], role.name)
  ]
}
# Assign users
resource "btp_subaccount_role_collection_assignment" "build_apps_admin" {
  for_each             = toset(var.build_apps_admins)
  subaccount_id        = var.subaccount_id
  role_collection_name = "BuildApps_Administrator"
  user_name            = each.value
  origin               = "sap.custom"
  depends_on           = [btp_subaccount_role_collection.build_apps_admin]
}

# ------------------------------------------------------------------------------------------------------
# Create/Assign role collection "BuildApps_Developer"
# ------------------------------------------------------------------------------------------------------
# Create
resource "btp_subaccount_role_collection" "build_apps_developer" {
  subaccount_id = var.subaccount_id
  name          = "BuildApps_Developer"

  roles = [
    for role in data.btp_subaccount_roles.all.values : {
      name                 = role.name
      role_template_app_id = role.app_id
      role_template_name   = role.role_template_name
    } if contains(["BuildApps_Developer"], role.name)
  ]
}
# Assign users
resource "btp_subaccount_role_collection_assignment" "build_apps_developer" {
  for_each             = toset(var.build_apps_developers)
  subaccount_id        = var.subaccount_id
  role_collection_name = "BuildApps_Developer"
  user_name            = each.value
  origin               = "sap.custom"
  depends_on           = [btp_subaccount_role_collection.build_apps_developer]
}
