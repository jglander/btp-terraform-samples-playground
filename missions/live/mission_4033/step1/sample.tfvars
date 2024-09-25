# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
# Your global account subdomain
globalaccount   = "ticoo"
region          = "us10"
subaccount_name = "4033-jgl-tf-kyma-us10-2509-3-a"
custom_idp      = "ag6010bvf.accounts.ondemand.com"

/*
kyma_instance = {
  name            = "my-kyma-environment"
  region          = "us-east-1"
  machine_type    = "mx5.xlarge"
  auto_scaler_min = 3
  auto_scaler_max = 20
  createtimeout   = "1h"
  updatetimeout   = "35m"
  deletetimeout   = "1h"
}
*/

# ------------------------------------------------------------------------------------------------------
# Project specific configuration (please adapt!)
# ------------------------------------------------------------------------------------------------------
subaccount_admins               = ["jens.glander@vodafone.de"]
subaccount_service_admins       = ["jens.glander@vodafone.de"]
int_provisioners                = ["jens.glander@vodafone.de"]
users_buildApps_admins          = ["jens.glander@vodafone.de"]
users_registry_admins           = ["jens.glander@vodafone.de"]
users_buildApps_developers      = ["jens.glander@vodafone.de"]
users_registry_developers       = ["jens.glander@vodafone.de"]
process_automation_admins       = ["jens.glander@vodafone.de"]
process_automation_developers   = ["jens.glander@vodafone.de"]
process_automation_participants = ["jens.glander@vodafone.de"]

