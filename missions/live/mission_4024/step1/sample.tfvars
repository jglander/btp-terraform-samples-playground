# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
# Your global account subdomain
#globalaccount = "<your-global-account-subdomain>"
globalaccount = "982b7367-5617-4968-b601-fa2ec71bf2f7" // qas demo 

# The CLI server URL (needs to be set to null if you are using the default CLI server)
cli_server_url = null

# custom_idp = "<<tenand id>>.accounts.ondemand.com"
custom_idp = "ae4w2ks65.accounts.ondemand.com"

# ------------------------------------------------------------------------------------------------------
# Subaccount configuration
# ------------------------------------------------------------------------------------------------------
# Region for your subaccount
region = "us10"

# Name of your sub account
#subaccount_name = "SAP Discovery Center Mission 4024 (SAP Build Apps)"
subaccount_name = "4024-jgl-0109c"

# ------------------------------------------------------------------------------------------------------
# User roles
# ------------------------------------------------------------------------------------------------------
subaccount_admins               = ["jens.glander@sap.com"]
launchpad_admins                = ["jens.glander@sap.com"]
build_apps_admins               = ["jens.glander@sap.com"]
build_apps_developers           = ["jens.glander@sap.com"]
build_apps_registry_admin       = ["jens.glander@sap.com"]
build_apps_registry_developer   = ["jens.glander@sap.com"]

# ------------------------------------------------------------------------------------------------------
# Create tfvars file for the step 2
# ------------------------------------------------------------------------------------------------------
create_tfvars_file_for_step2 = true
