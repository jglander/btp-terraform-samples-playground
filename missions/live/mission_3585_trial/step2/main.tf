# ------------------------------------------------------------------------------------------------------
# SUBSCRIPTIONS
# ------------------------------------------------------------------------------------------------------
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
# ------------------------------------------------------------------------------------------------------
# Assign role collection "Launchpad_Admin"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "launchpad_admin" {
  for_each             = toset(var.launchpad_admins)
  subaccount_id        = var.subaccount_id
  role_collection_name = "Launchpad_Admin"
  user_name            = each.value
  origin               = "sap.custom"
  depends_on           = [btp_subaccount_subscription.sap_launchpad]
}
