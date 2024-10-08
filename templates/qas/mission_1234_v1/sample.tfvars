# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
#custom_idp = "ag6010bvf.accounts.ondemand.com" // TechEd Demo
#custom_idp = "ar9ibaxhm.accounts.ondemand.com" // BTP Design Core FS-B
custom_idp = "ae4w2ks65.accounts.ondemand.com" // QAS demo
#custom_idp    = "ae4w2ks65.accounts.ondemand.com" // QAS demo TST4

# ------------------------------------------------------------------------------------------------------
# Account settings
# ------------------------------------------------------------------------------------------------------
#globalaccount   = "ticoo" // TechEd Demo
#globalaccount   = "sapcpua" // BTP Design Core FS-B
globalaccount   = "982b7367-5617-4968-b601-fa2ec71bf2f7" // QAS demo
#globalaccount = "d64156f7-9905-44a0-8343-4fcb0dc93ee8" // QAS demo TST4

subaccount_admins         = ["jens.glander@vodafone.de"]
subaccount_service_admins = ["jens.glander@vodafone.de"]

# ------------------------------------------------------------------------------------------------------
# Use case specific configuration
# ------------------------------------------------------------------------------------------------------
#service_env_plan__cloudfoundry = "free"

cf_org_managers     = ["jens.glander@vodafone.de"]
cf_org_users        = ["jens.glander@vodafone.de"]
cf_space_managers   = ["jens.glander@vodafone.de"]
cf_space_developers = ["jens.glander@vodafone.de"]
