# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
# Your global account subdomain
#globalaccount = "xxxxxxxx-xxxxxxx-xxxxxxx-xxxxxxxx-xxxxxx"
globalaccount = "982b7367-5617-4968-b601-fa2ec71bf2f7"

# The CLI server URL (needs to be set to null if you are using the default CLI server)
#cli_server_url = null

# Region for your subaccount
region = "us10"

# Name of your sub account
#subaccount_name = "SAP Discovery Center Mission 3585"
subaccount_name = "jgl-3585-0309i"

use_optional_resources = true

# ------------------------------------------------------------------------------------------------------
# USER ROLES
# ------------------------------------------------------------------------------------------------------
subaccount_admins   = ["another.user@test.com"]

bas_admins          = ["another.user@test.com", "you@test.com"]
bas_developers      = ["another.user@test.com", "you@test.com"]

launchpad_admins    = ["another.user@test.com", "you@test.com"]

cicd_admins         = ["another.user@test.com", "you@test.com"]
cicd_developers     = ["another.user@test.com", "you@test.com"]