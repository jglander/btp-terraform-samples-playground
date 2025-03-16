# ------------------------------------------------------------------------------------------------------
# Subaccount setup for DC mission 1234 (trial)
# ------------------------------------------------------------------------------------------------------
# Setup subaccount domain (to ensure uniqueness in BTP global account)
resource "random_uuid" "uuid" {}

locals {
  random_uuid       = random_uuid.uuid.result
  subaccount_domain = "dcmission4024${local.random_uuid}"
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

data "btp_subaccount" "subaccount" {
  id = data.btp_subaccount.dc_mission.id
}
# ------------------------------------------------------------------------------------------------------
# SERVICES
# ------------------------------------------------------------------------------------------------------
#
locals {
  service_name__alert_notification = "alert-notification"
}

# ------------------------------------------------------------------------------------------------------
# Setup alert-notification (Alert Notification Service)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "alert_notification" {
  subaccount_id = data.btp_subaccount.dc_mission.id
  service_name  = local.service_name__alert_notification
  plan_name     = var.service_plan__alert_notification
}

# Get plan for alert notification service
data "btp_subaccount_service_plan" "by_name" {
  subaccount_id = data.btp_subaccount.dc_mission.id
  name          = var.service_plan__alert_notification
  offering_name = local.service_name__alert_notification
}

# Create alert notification for Visual Cloud Functions
resource "btp_subaccount_service_instance" "alert_notification" {
  subaccount_id  = data.btp_subaccount.dc_mission.id
  serviceplan_id = data.btp_subaccount_service_plan.by_name.id
  name           = local.service_name__alert_notification
}

# ------------------------------------------------------------------------------------------------------
# APP SUBSCRIPTIONS
# ------------------------------------------------------------------------------------------------------
#
locals {
  service_name__auditlog_viewer = "auditlog-viewer"
  # optional
  service_name__automationpilot = "automationpilot"
}

# ------------------------------------------------------------------------------------------------------
# Setup auditlog-viewer (Audit Log Viewer Service)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "auditlog_viewer" {
  subaccount_id = data.btp_subaccount.dc_mission.id
  service_name  = local.service_name__auditlog_viewer
  plan_name     = var.service_plan__auditlog_viewer
  #amount        = 1
}
# Subscribe
resource "btp_subaccount_subscription" "auditlog_viewer" {
  subaccount_id = data.btp_subaccount.dc_mission.id
  app_name      = local.service_name__auditlog_viewer
  plan_name     = var.service_plan__auditlog_viewer
  depends_on    = [btp_subaccount_entitlement.auditlog_viewer]
}

# ------------------------------------------------------------------------------------------------------
# Setup automationpilot (Automation Pilot)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "automationpilot" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id = data.btp_subaccount.dc_mission.id
  service_name  = local.service_name__automationpilot
  plan_name     = var.service_plan__automationpilot
  #amount        = 1
}
# Subscribe
resource "btp_subaccount_subscription" "automationpilot" {
  count         = var.use_optional_resources ? 1 : 0
  subaccount_id = data.btp_subaccount.dc_mission.id
  app_name      = "automationpilot"
  plan_name     = var.service_plan__automationpilot
  depends_on    = [btp_subaccount_entitlement.automationpilot]
}

# ------------------------------------------------------------------------------------------------------
#  USERS AND ROLES
# ------------------------------------------------------------------------------------------------------
#
# Get all roles in the subaccount
data "btp_subaccount_roles" "all" {
  subaccount_id = data.btp_subaccount.dc_mission.id
}
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
