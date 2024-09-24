# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
# Your global account subdomain
globalaccount   = "ticoo"
region          = "us10"
subaccount_name = "3774-jgl-tf-2409f"

custom_idp       = "" //"sap.ids"

service_plan__build_workzone = "free"

# ------------------------------------------------------------------------------------------------------
# Project specific configuration (please adapt!)
# ------------------------------------------------------------------------------------------------------
# Don't add the user, that is executing the TF script to subaccount_admins or subaccount_service_admins
subaccount_admins         = ["jens.glander@vodafone.de"]
subaccount_service_admins = ["jens.glander@vodafone.de"]

# Don't add the user, that is executing the TF script to cf_org_admins or cf_org_users!
cf_org_admins       = ["jens.glander@vodafone.de"]
cf_org_users        = ["jens.glander@vodafone.de"]
cf_space_managers   = ["jens.glander@vodafone.de"]
cf_space_developers = ["jens.glander@vodafone.de"]

launchpad_admins = ["jens.glander@vodafone.de"]

create_tfvars_file_for_step2 = true
