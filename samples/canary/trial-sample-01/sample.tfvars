# The CLI server URL (needs to be set to null if you are using the default CLI server)
#cli_server_url = null
cli_server_url  = "https://canary.cli.btp.int.sap/"

# ------------------------------------------------------------------------------------------------------
# Account settings
# ------------------------------------------------------------------------------------------------------
# Your global account subdomain
#globalaccount = "<your-globalaccount-subdomain>" // <xxxxxxxx>trial-ga
#subaccount_id = "<your trial Subaccount ID>"

# user jglsap (canary)
globalaccount  = "922102d4trial-ga"
#subaccount_id   = "7f5b0692-8720-426d-94d3-8a2c85495f9e" // trial default
subaccount_id   = "6d50f559-19ab-44a5-8c27-db72497e03f1" // mytrial2

# user jglvod canary
#globalaccount  = "f6c5026btrial-ga" // jglvod canary
#subaccount_id   = "b57ce027-68e7-4dae-80a0-f304ce99fe36" // trial default
#subaccount_id   = "47ad901a-b984-4d88-b40e-cf20794201bc" // mytrial

# ------------------------------------------------------------------------------------------------------
# Use case specific role assignments
# ------------------------------------------------------------------------------------------------------
subaccount_admins             = ["jane.doe@acme.com"]

use_optional_resources = true // default false