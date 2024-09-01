# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
# Your global account subdomain
globalaccount = "775253e0-3e95-4cde-b005-cdc3688cdc2c" // cas demo canary

# The CLI server URL (needs to be set to null if you are using the default CLI server)
#cli_server_url = null
cli_server_url = "https://canary.cli.btp.int.sap/"

# Region for your subaccount
#region = "us10"
region = "eu10-canary"

# Name of your sub account
#subaccount_name = "SAP Discovery Center Mission 4441 (SAP Build Code)"
subaccount_name = "4441-jgl-can-2208e"

# ------------------------------------------------------------------------------------------------------
# Create tfvars file for the step 2
# ------------------------------------------------------------------------------------------------------
create_tfvars_file_for_step2 = true

# ------------------------------------------------------------------------------------------------------
# USER ROLES
# ------------------------------------------------------------------------------------------------------
subaccount_admins     = ["another.user@test.com"]
cf_org_admins         = ["another.user@test.com"]
cf_space_managers     = ["another.user@test.com", "jens.glander@vodafone.de"]
cf_space_developers   = ["another.user@test.com", "jens.glander@vodafone.de"]
build_code_admins     = ["another.user@test.com", "jens.glander@vodafone.de"]
build_code_developers = ["another.user@test.com", "jens.glander@vodafone.de"]
