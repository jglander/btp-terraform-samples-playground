###############################################################################################
# Prepare CF
###############################################################################################
# Entitle subaccount for usage of cf runtime

data "btp_globalaccount" "this" {}

resource "btp_subaccount_entitlement" "prepare_cf" {
  // global accounts which use consumption-based commercial model are implicitly entitled, see https://help.sap.com/docs/btp/sap-business-technology-platform/what-is-consumption-based-commercial-model
  count = data.btp_globalaccount.this.consumption_based ? 0 : 1

  subaccount_id = var.subaccount_id
  service_name  = local.service_name__cf_runtime
  plan_name     = var.service_plan__cf_runtime
  amount        = 1
}
