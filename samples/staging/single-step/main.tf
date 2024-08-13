###############################################################################################
# Setup subaccount domain and the CF org (to ensure uniqueness in BTP global account)
###############################################################################################
resource "random_uuid" "uuid" {}

locals {
  random_uuid               = random_uuid.uuid.result
  project_subaccount_domain = "buildapps${local.random_uuid}"
}

###############################################################################################
# Creation of subaccount
###############################################################################################
resource "btp_subaccount" "create_subaccount" {
  count = var.subaccount_id == "" ? 1 : 0

  name      = var.subaccount_name
  subdomain = local.project_subaccount_domain
  region    = lower(var.region)
  usage     = "USED_FOR_PRODUCTION"
}

data "btp_subaccount" "project" {
  id = var.subaccount_id != "" ? var.subaccount_id : btp_subaccount.create_subaccount[0].id
}

###############################################################################################
# Prepare CF
###############################################################################################
# Entitle subaccount for usage of cf runtime

resource "btp_subaccount_entitlement" "prepare_cf" {
  subaccount_id = data.btp_subaccount.project.id
  service_name  = local.service_name__cf_runtime
  plan_name     = var.service_plan__cf_runtime
  amount        = 1
}
