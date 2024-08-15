locals {
  bas_admins = var.use_optional_resources == true ? var.bas_admins : []
  bas_developers = var.use_optional_resources == true ? var.bas_developers : []
}

# ------------------------------------------------------------------------------------------------------
# Subaccount setup for DC mission 3585
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

data "btp_subaccount" "project" {
  id = var.subaccount_id != "" ? var.subaccount_id : btp_subaccount.dc_mission[0].id
}

# ------------------------------------------------------------------------------------------------------
# APP SUBSCRIPTIONS
# ------------------------------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------------------------------
# Setup sapappstudio
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "sapappstudio" {
  count         = var.use_optional_resources == true ? 1 : 0
  subaccount_id = data.btp_subaccount.project.id
  service_name  = "sapappstudiotrial"
  plan_name     = "trial" 
}

# Subscribe (depends on subscription of standard-edition)
resource "btp_subaccount_subscription" "sapappstudio" {
  count         = var.use_optional_resources == true ? 1 : 0
  subaccount_id = data.btp_subaccount.project.id
  app_name      = "sapappstudiotrial" 
  plan_name     = "trial" 
  
  depends_on    = [btp_subaccount_entitlement.sapappstudio]
}

data "btp_subaccount_subscription" "sapappstudio" {
  subaccount_id = data.btp_subaccount.project.id
  app_name      = "sapappstudiotrial"
  plan_name     = "trial"
}

# ------------------------------------------------------------------------------------------------------
# Setup SAPLaunchpad (SAP Build Work Zone, standard edition)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "sap_launchpad" {
  subaccount_id = data.btp_subaccount.project.id
  service_name  = "SAPLaunchpad"
  plan_name     = "standard"
}
# Subscribe
resource "btp_subaccount_subscription" "sap_launchpad" {
  subaccount_id = data.btp_subaccount.project.id
  app_name      = "SAPLaunchpad"
  plan_name     = "standard"
  depends_on    = [btp_subaccount_entitlement.sap_launchpad]
}

# ------------------------------------------------------------------------------------------------------
#  USERS AND ROLES
# ------------------------------------------------------------------------------------------------------
#
# Get all available subaccount roles
data "btp_subaccount_roles" "all" {
  subaccount_id = data.btp_subaccount.project.id
  depends_on    = [btp_subaccount_subscription.sap_launchpad, btp_subaccount_subscription.sapappstudio, /*btp_subaccount_subscription.cicd_app*/]
}

# ------------------------------------------------------------------------------------------------------
# Assign role collection "Launchpad_Admin"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "launchpad_admin" {
  for_each             = toset("${var.launchpad_admins}")
  subaccount_id        = data.btp_subaccount.project.id
  role_collection_name = "Launchpad_Admin"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.sap_launchpad]
}


# ------------------------------------------------------------------------------------------------------
# Assign role collection "Subaccount Administrator"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "subaccount_admin" {
  for_each             = toset("${var.subaccount_admins}")
  subaccount_id        = data.btp_subaccount.project.id
  role_collection_name = "Subaccount Administrator"
  user_name            = each.value
  depends_on           = [btp_subaccount.dc_mission]
}

# ------------------------------------------------------------------------------------------------------
# Assign role collection "Business_Application_Studio_Administrator"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "bas_admins" {
  for_each             = toset("${local.bas_admins}")
  subaccount_id        = data.btp_subaccount.project.id
  role_collection_name = "Business_Application_Studio_Administrator"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.sapappstudio]
}

# ------------------------------------------------------------------------------------------------------
# Assign role collection "Business_Application_Studio_Developer"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "bas_developer" {  
  for_each             = toset("${local.bas_developers}")
  subaccount_id        = data.btp_subaccount.project.id
  role_collection_name = "Business_Application_Studio_Developer"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.sapappstudio]
}
