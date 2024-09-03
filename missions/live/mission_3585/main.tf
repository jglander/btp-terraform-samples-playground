# ------------------------------------------------------------------------------------------------------
# Subaccount setup for DC mission 3585
# ------------------------------------------------------------------------------------------------------
# Setup subaccount domain (to ensure uniqueness in BTP global account)
resource "random_uuid" "uuid" {}

# ------------------------------------------------------------------------------------------------------
# Creation of subaccount
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount" "dc_mission" {
  name      = var.subaccount_name
  subdomain = join("-", ["dc-mission-3585", random_uuid.uuid.result])
  region    = lower(var.region)
}

# ------------------------------------------------------------------------------------------------------
# SERVICES
# ------------------------------------------------------------------------------------------------------
#
locals {
  # optional
  service_name__cicd_service = "cicd-service"
}
# ------------------------------------------------------------------------------------------------------
# Setup cicd-service (SAP Continuous Integration and Delivery), (not running in CF environment)
# ------------------------------------------------------------------------------------------------------
# Entitle 
resource "btp_subaccount_entitlement" "cicd_service" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id = btp_subaccount.dc_mission.id
  service_name  = local.service_name__cicd_service
  plan_name     = var.service_plan__cicd_service
}
# Get serviceplan_id for cicd-service with plan_name "default"
data "btp_subaccount_service_plan" "cicd_service" {
  subaccount_id = btp_subaccount.dc_mission.id
  offering_name = local.service_name__cicd_service
  name          = var.service_plan__cicd_service
  depends_on    = [btp_subaccount_entitlement.cicd_service]
}
# Create service instance
resource "btp_subaccount_service_instance" "cicd_service" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id  = btp_subaccount.dc_mission.id
  serviceplan_id = data.btp_subaccount_service_plan.cicd_service.id
  name           = "default_cicd-service"
  # Subscription to the cicd-app subscription is required for creating the service instance
  # See as well https://help.sap.com/docs/continuous-integration-and-delivery/sap-continuous-integration-and-delivery/optional-enabling-api-usage?language=en-US
  depends_on = [btp_subaccount_subscription.cicd_app]
}

# ------------------------------------------------------------------------------------------------------
# APP SUBSCRIPTIONS
# ------------------------------------------------------------------------------------------------------
#
locals {
  service_name__sapappstudio  = "sapappstudio"
  # optional
  service_name__sap_launchpad = "SAPLaunchpad"
  service_name__cicd_app      = "cicd-app"

}
# ------------------------------------------------------------------------------------------------------
# Setup sapappstudio (SAP Business Application Studio)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "sapappstudio" {
  subaccount_id = btp_subaccount.dc_mission.id
  service_name  = local.service_name__sapappstudio
  plan_name     = var.service_plan__sapappstudio
}
# Subscribe (depends on subscription of standard-edition)
resource "btp_subaccount_subscription" "sapappstudio" {
  subaccount_id = btp_subaccount.dc_mission.id
  app_name      = local.service_name__sapappstudio
  plan_name     = var.service_plan__sapappstudio
  depends_on    = [btp_subaccount_entitlement.sapappstudio]
}

# ------------------------------------------------------------------------------------------------------
# Setup SAPLaunchpad (SAP Build Work Zone, standard edition)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "sap_launchpad" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id = btp_subaccount.dc_mission.id
  service_name  = local.service_name__sap_launchpad
  plan_name     = var.service_plan__sap_launchpad
  amount        = var.service_plan__sap_launchpad == "free" ? 1 : null
}
# Subscribe
resource "btp_subaccount_subscription" "sap_launchpad" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id = btp_subaccount.dc_mission.id
  app_name      = local.service_name__sap_launchpad
  plan_name     = var.service_plan__sap_launchpad
  depends_on    = [btp_subaccount_entitlement.sap_launchpad]
}
data "btp_subaccount_subscription" "sap_launchpad" {
  subaccount_id = btp_subaccount.dc_mission.id
  app_name      = local.service_name__sap_launchpad
  plan_name     = var.service_plan__sap_launchpad
  depends_on    = [btp_subaccount_subscription.sap_launchpad]
}

# ------------------------------------------------------------------------------------------------------
# Setup cicd-app (Continuous Integration & Delivery)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "cicd_app" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id = btp_subaccount.dc_mission.id
  service_name  = local.service_name__cicd_app
  plan_name     = var.service_plan__cicd_app
  amount        = var.service_plan__cicd_app == "free" ? 1 : null
}
# Subscribe
resource "btp_subaccount_subscription" "cicd_app" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id = btp_subaccount.dc_mission.id
  app_name      = local.service_name__cicd_app
  plan_name     = var.service_plan__cicd_app
  depends_on    = [btp_subaccount_entitlement.cicd_app]
}
data "btp_subaccount_subscription" "cicd_app" {
  subaccount_id = btp_subaccount.dc_mission.id
  app_name      = local.service_name__cicd_app
  plan_name     = var.service_plan__cicd_app
  depends_on    = [btp_subaccount_subscription.cicd_app]
}

# ------------------------------------------------------------------------------------------------------
#  USERS AND ROLES
# ------------------------------------------------------------------------------------------------------
#
# Get all available subaccount roles
data "btp_subaccount_roles" "all" {
  subaccount_id = btp_subaccount.dc_mission.id
  depends_on    = [btp_subaccount_subscription.sap_launchpad, btp_subaccount_subscription.sapappstudio, btp_subaccount_subscription.cicd_app]
}

# ------------------------------------------------------------------------------------------------------
# Assign role collection "Subaccount Administrator"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "subaccount_admin" {
  for_each             = toset("${var.subaccount_admins}")
  subaccount_id        = btp_subaccount.dc_mission.id
  role_collection_name = "Subaccount Administrator"
  user_name            = each.value
  depends_on           = [btp_subaccount.dc_mission]
}

# ------------------------------------------------------------------------------------------------------
# Assign role collection "Business_Application_Studio_Administrator"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "bas_admins" {
  for_each             = toset("${var.bas_admins}")
  subaccount_id        = btp_subaccount.dc_mission.id
  role_collection_name = "Business_Application_Studio_Administrator"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.sapappstudio]
}

# ------------------------------------------------------------------------------------------------------
# Assign role collection "Business_Application_Studio_Developer"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "bas_developer" {
  for_each             = toset("${var.bas_developers}")
  subaccount_id        = btp_subaccount.dc_mission.id
  role_collection_name = "Business_Application_Studio_Developer"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.sapappstudio]
}

# ------------------------------------------------------------------------------------------------------
# Assign role collection "Launchpad_Admin"
# ------------------------------------------------------------------------------------------------------
# optional app subscription
locals {
  launchpad_admins = var.use_optional_resources == true ? var.launchpad_admins : []
}
resource "btp_subaccount_role_collection_assignment" "launchpad_admin" {
  for_each             = toset("${local.launchpad_admins}")
  subaccount_id        = btp_subaccount.dc_mission.id
  role_collection_name = "Launchpad_Admin"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.sap_launchpad]
}

# ------------------------------------------------------------------------------------------------------
# Assign role collection "CICD Service Administrator"
# ------------------------------------------------------------------------------------------------------
# optional app subscription
locals {
  cicd_admins = var.use_optional_resources == true ? var.cicd_admins : []
}
resource "btp_subaccount_role_collection_assignment" "cicd_admins" {
  for_each             = toset("${local.cicd_admins}")
  subaccount_id        = btp_subaccount.dc_mission.id
  role_collection_name = "CICD Service Administrator"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.cicd_app]
}

# ------------------------------------------------------------------------------------------------------
# Assign role collection "CICD Service Developer"
# ------------------------------------------------------------------------------------------------------
# optional app subscription
locals {
  cicd_developers = var.use_optional_resources == true ? var.cicd_developers : []
}
resource "btp_subaccount_role_collection_assignment" "cicd_developers" {
  for_each             = toset("${var.cicd_developers}")
  subaccount_id        = btp_subaccount.dc_mission.id
  role_collection_name = "CICD Service Developer"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.cicd_app]
}
