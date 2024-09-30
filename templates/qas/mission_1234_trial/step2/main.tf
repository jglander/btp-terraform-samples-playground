# ------------------------------------------------------------------------------------------------------
# ENVIRONMENTS
# ------------------------------------------------------------------------------------------------------
# Setup Cloud Foundry Org (space, user role assignments)
# ------------------------------------------------------------------------------------------------------
# Create space
resource "cloudfoundry_space" "dev" {
  count = var.create_cf_space ? 1 : 0
  name = var.cf_space_name
  org  = var.cf_org_id
}

data "cloudfoundry_space" "dev" {
  count = var.create_cf_space ? 0 : 1
  name  = var.cf_space_name
  org   = var.cf_org_id
}

locals {
  space_id = var.create_cf_space ? cloudfoundry_space.dev[0].id : data.cloudfoundry_space.dev[0].id
}

# user role assignments
data "btp_whoami" "me" {}

locals {
  cf_org_managers     = setsubtract(toset(var.cf_org_managers), [data.btp_whoami.me.email])
  cf_org_users        = setsubtract(toset(var.cf_org_users), [data.btp_whoami.me.email])
  cf_space_managers   = var.create_cf_space ? var.cf_space_managers : setsubtract(toset(var.cf_space_managers), [data.btp_whoami.me.email])
  cf_space_developers = var.create_cf_space ? var.cf_space_developers : setsubtract(toset(var.cf_space_developers), [data.btp_whoami.me.email])
}

# cf_org_managers: Assign organization_manager role
resource "cloudfoundry_org_role" "org_managers" {
  for_each = toset(local.cf_org_managers)
  username = each.value
  type     = "organization_manager"
  org      = var.cf_org_id
}

# cf_org_users: Assign organization_user role
resource "cloudfoundry_org_role" "org_users" {
  for_each = toset(local.cf_org_users)
  username = each.value
  type     = "organization_user"
  org      = var.cf_org_id
}

# cf_space_managers: Assign space_manager role
resource "cloudfoundry_space_role" "space_managers" {
  for_each = toset(local.cf_space_managers)
  username = each.value
  type     = "space_manager"
  space    = local.space_id
}

# cf_space_developers: Assign space_developer role
resource "cloudfoundry_space_role" "space_developers" {
  for_each = toset(local.cf_space_developers)
  username = each.value
  type     = "space_developer"
  space    = local.space_id
}

# ------------------------------------------------------------------------------------------------------
# SERVICES

/*
# ------------------------------------------------------------------------------------------------------
# Setup abap-trial (ABAP environment)
# ------------------------------------------------------------------------------------------------------
#
locals {
  service_name__abap_trial   = "abap-trial"
}

data "cloudfoundry_service" "abap_service_plans" {
  name = local.service_name__abap_trial
}

# Instance creation
resource "cloudfoundry_service_instance" "abap_trial" {
  depends_on   = [cloudfoundry_space_role.space_managers, cloudfoundry_space_role.space_developers]
  name         = local.service_name__abap_trial
  space        = local.space_id
  service_plan = data.cloudfoundry_service.abap_service_plans.service_plans[var.service_plan__abap_trial]
  type         = "managed"
  parameters = jsonencode({
    email = "${var.abap_admin_email}"
  })
  timeouts = {
    create = "30m"
    delete = "30m"
    update = "30m"
  }
}

# Service key creation (for ABAP Development Tools (ADT))
resource "cloudfoundry_service_credential_binding" "abap_trial_service_key" {
  type             = "key"
  name             = "abap_trial_adt_key"
  service_instance = cloudfoundry_service_instance.abap_trial.id
}
*/