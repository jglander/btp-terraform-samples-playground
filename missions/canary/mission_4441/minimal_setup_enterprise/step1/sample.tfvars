# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
#custom_idp = "<<tenant-id>>.accounts.ondemand.com"

# ------------------------------------------------------------------------------------------------------
# Account settings
# ------------------------------------------------------------------------------------------------------
#globalaccount = "982b7367-5617-4968-b601-fa2ec71bf2f7"
globalaccount = "775253e0-3e95-4cde-b005-cdc3688cdc2c" // cas demo canary

#region        = "us10"
region = "eu10-canary"

#cli_server_url = null
cli_server_url = "https://canary.cli.btp.int.sap/"

subaccount_name = "4441-jgl-b"

# ------------------------------------------------------------------------------------------------------
# Use case specific configuration
# ------------------------------------------------------------------------------------------------------
subaccount_admins     = ["jens.glander@vodafone.de"]
build_code_admins     = ["jens.glander@vodafone.de"]
build_code_developers = ["jens.glander@vodafone.de"]

cf_org_admins       = ["jens.glander@vodafone.de"]
cf_space_managers   = ["jens.glander@vodafone.de"]
cf_space_developers = ["jens.glander@vodafone.de"]

# ------------------------------------------------------------------------------------------------------
# Create tfvars file for the step 2
# ------------------------------------------------------------------------------------------------------
create_tfvars_file_for_step2 = true
