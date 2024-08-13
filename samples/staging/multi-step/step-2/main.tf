###############################################################################################
# Prepare CF
###############################################################################################
# Entitle subaccount for usage of cf runtime

resource "btp_subaccount_entitlement" "prepare_cf" {
  subaccount_id = var.subaccount_id
  service_name  = local.service_name__cf_runtime
  plan_name     = var.service_plan__cf_runtime
  amount        = 1
}
