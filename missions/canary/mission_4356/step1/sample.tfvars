# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
custom_idp = "sap.ids"
cli_server_url = "https://canary.cli.btp.int.sap/"

# ------------------------------------------------------------------------------------------------------
# Project specific configuration (please adapt!)
# ------------------------------------------------------------------------------------------------------
#globalaccount = "775253e0-3e95-4cde-b005-cdc3688cdc2c" // qas demo
#globalaccount = "e4c1b2b6-6884-4c99-b8fd-f6054bd4e22c" // sol pioneer
#region          = "us10"
#subaccount_name = "4356-jgl-1708a"

// canary
#globalaccount = "experienceoneag-01" // cpt-team-cf-eu10-canary_(ppu)
globalaccount = "775253e0-3e95-4cde-b005-cdc3688cdc2c" // qas demo
region          = "eu10-canary"
subaccount_name = "4356-tf-jgl-can-1708c"

service_plan__sap_integration_suite = "standard_edition"

subaccount_admins         = ["jens.glander@vodafone.de", "jens.glander@sap.com"]
subaccount_service_admins = ["jens.glander@vodafone.de", "jens.glander@sap.com"]

int_provisioners          = ["jens.glander@vodafone.de", "jens.glander@sap.com"]
cloudconnector_admins     = ["jens.glander@vodafone.de", "jens.glander@sap.com"]
conn_dest_admins          = ["jens.glander@vodafone.de", "jens.glander@sap.com"]

cf_org_users              = ["jens.glander@vodafone.de", "jens.glander@sap.com"]
cf_org_admins             = ["jens.glander@vodafone.de", "jens.glander@sap.com"]
cf_space_managers         = ["jens.glander@vodafone.de", "jens.glander@sap.com"]
cf_space_developers       = ["jens.glander@vodafone.de", "jens.glander@sap.com"]

