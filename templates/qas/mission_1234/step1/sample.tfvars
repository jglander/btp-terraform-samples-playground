# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
custom_idp = "ag6010bvf.accounts.ondemand.com"

# ------------------------------------------------------------------------------------------------------
# Account settings
# ------------------------------------------------------------------------------------------------------
globalaccount   = "ticoo"
region          = "us10"
subaccount_name = "1234-tf-qas-template-jgl-0310a"

# ------------------------------------------------------------------------------------------------------
# Use case specific configuration
# ------------------------------------------------------------------------------------------------------
subaccount_admins         = ["jens.glander@vodafone.de"]
subaccount_service_admins = ["jens.glander@vodafone.de"]

integration_provisioners = ["jens.glander@vodafone.de"]
sapappstudio_admins      = ["jens.glander@vodafone.de"]
sapappstudio_developers  = ["jens.glander@vodafone.de"]

cloud_connector_admins          = ["jens.glander@vodafone.de"]
connectivity_destination_admins = ["jens.glander@vodafone.de"]

cf_org_managers     = ["jens.glander@vodafone.de"]
cf_org_users        = ["jens.glander@vodafone.de"]
cf_space_managers   = ["jens.glander@vodafone.de"]
cf_space_developers = ["jens.glander@vodafone.de"]

# ------------------------------------------------------------------------------------------------------
# Create tfvars file for the step 2
# ------------------------------------------------------------------------------------------------------
create_tfvars_file_for_step2 = true