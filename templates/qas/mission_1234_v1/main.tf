# ------------------------------------------------------------------------------------------------------
# Subaccount setup for DC mission 1234_v1
# ------------------------------------------------------------------------------------------------------
# Setup subaccount domain (to ensure uniqueness in BTP global account)
resource "random_uuid" "uuid" {}

locals {
  random_uuid       = random_uuid.uuid.result
  timestamp         = formatdate("YYYYMMDDhhmmss", timestamp())
  subaccount_domain = "dcmission1234-v1${local.random_uuid}"
  subaccount_name   = var.subaccount_name == "" ? "SAP Discovery Center Mission 1234_v1 - ${local.timestamp}" : var.subaccount_name
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
# Entitle
resource "btp_subaccount_entitlement" "cloudfoundry" {
  count         = var.service_env_plan__cloudfoundry == "free" ? 1 : 0
  subaccount_id = btp_subaccount.dc_mission[0].id
  service_name  = local.service_env_name__cloudfoundry
  plan_name     = var.service_env_plan__cloudfoundry
  amount        = var.service_env_plan__cloudfoundry == "free" ? 1 : 0
}

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
  cf_org_name   = var.cf_org_name == "" ? "cf_org_name_dcmission_1234_v1_${local.random_uuid}" : var.cf_org_name
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
  depends_on    = [btp_subaccount_entitlement.cloudfoundry]
}