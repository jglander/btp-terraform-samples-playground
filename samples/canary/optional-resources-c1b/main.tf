resource "random_uuid" "uuid" {}

locals {
  random_uuid       = random_uuid.uuid.result
  subaccount_domain = "${local.random_uuid}"

  # used (mandatory) services
  service_name__sap_launchpad         = "SAPLaunchpad"
  service_name__destination           = "destination"
  service_name__aicore                = "aicore"

  # used (optional) services
  service_name__application_runtime   = "APPLICATION_RUNTIME"
  service_name__sap_build_apps        = "sap-build-apps"
  service_name__canary_saas           = "canary-saas"

  # for testing
  use_service__sap_launchpad          = true
  use_service__destination            = true
  use_service__aicore                 = true
  use_service__application_runtime    = false
  use_service__sap_build_apps         = true
  use_service__canary_saas            = true
}

data "btp_globalaccount" "this" {}

# ------------------------------------------------------------------------------------------------------
# Creation of subaccount
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount" "qas_sample" {
  count = var.subaccount_id == "" ? 1 : 0

  name      = var.subaccount_name
  subdomain = local.subaccount_domain
  region    = var.region
}

data "btp_subaccount" "qas_sample" {
  id = var.subaccount_id != "" ? var.subaccount_id : btp_subaccount.qas_sample[0].id
}

# ------------------------------------------------------------------------------------------------------
# Setup SAPLaunchpad (SAP Build Work Zone, standard edition)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "sap_launchpad" {
  count = local.use_service__sap_launchpad ? 1 : 0

  subaccount_id = data.btp_subaccount.qas_sample.id
  service_name  = local.service_name__sap_launchpad
  plan_name     = var.service_plan__sap_launchpad
}
# Subscribe
# optional-resources sample requires only the entitle step, subscription is skipped for simplicity reasons

# ------------------------------------------------------------------------------------------------------
# Setup destination (Destination Service)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "destination" {
  count = local.use_service__destination ? 1 : 0

  subaccount_id = data.btp_subaccount.qas_sample.id
  service_name  = local.service_name__destination
  plan_name     = var.service_plan__destination
  amount        = 1
}

# ------------------------------------------------------------------------------------------------------
# Setup aicore (SAP AI Core)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "aicore" {
  count = local.use_service__aicore ? 1 : 0
 
  subaccount_id = data.btp_subaccount.qas_sample.id
  service_name  = local.service_name__aicore
  plan_name     = var.service_plan__aicore
  amount        = 1
}

# ------------------------------------------------------------------------------------------------------
# Setup (Cloud Foundry) application_runtime
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "cf_application_runtime" {
  // consumption-based commercial model global accounts are entitled by default
  // see https://help.sap.com/docs/btp/sap-business-technology-platform/what-is-consumption-based-commercial-model
  count         = var.use_optional_resources && local.use_service__application_runtime && !data.btp_globalaccount.this.consumption_based ? 1 : 0
  
  subaccount_id = data.btp_subaccount.qas_sample.id
  service_name  = local.service_name__application_runtime
  plan_name     = var.service_plan__application_runtime
  amount        = 1
}

# ------------------------------------------------------------------------------------------------------
# Setup sap-build-apps (SAP Build Apps)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "sap_build_apps" {
  count = var.use_optional_resources && local.use_service__sap_build_apps ? 1 : 0

  subaccount_id = data.btp_subaccount.qas_sample.id
  service_name  = local.service_name__sap_build_apps
  plan_name     = var.service_plan__sap_build_apps
  amount        = 1
}
# Subscribe
# optional-resources sample requires only the entitle step, subscription is skipped for simplicity reasons

# ------------------------------------------------------------------------------------------------------
# Setup canary-saas (SAP Business Application Studio)
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "canary-saas" {
  count = var.use_optional_resources && local.use_service__canary_saas ? 1 : 0
  
  subaccount_id = data.btp_subaccount.qas_sample.id
  service_name  = local.service_name__canary_saas
  plan_name     = var.service_plan__canary_saas
}
