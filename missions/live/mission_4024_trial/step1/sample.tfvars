# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
# Your global account subdomain
#globalaccount = "<your-global-account-subdomain>"
#globalaccount   = "982b7367-5617-4968-b601-fa2ec71bf2f7" // qas demo, live
#globalaccount  = "775253e0-3e95-4cde-b005-cdc3688cdc2c" // qas demo, canary

globalaccount  = "590ab864trial-ga" // trial jgl-vod


# The CLI server URL (needs to be set to null if you are using the default CLI server)
#cli_server_url = null
#cli_server_url = "https://canary.cli.btp.int.sap/"

# custom_idp    = "<<tenand id>>.accounts.ondemand.com"
#custom_idp      = "ae4w2ks65.accounts.ondemand.com"
#custom_idp     = "acpserr5c.accounts400.ondemand.com"

# ------------------------------------------------------------------------------------------------------
# Subaccount configuration
# ------------------------------------------------------------------------------------------------------
# Region for your subaccount
region = "us10"
#region = "eu12"

# Name of your sub account
#subaccount_name = "SAP Discovery Center Mission 4024 (SAP Build Apps)"
subaccount_name = "4024-jgl-can-0109a"

subaccount_id = "ed178fd3-8979-4bac-8a22-dc6beeb00faf"

service_plan__sap_launchpad   = "standard"

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
