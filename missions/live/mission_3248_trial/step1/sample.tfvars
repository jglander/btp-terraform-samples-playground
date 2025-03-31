# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
# Your global account subdomain
#globalaccount = "<your-globalaccount-subdomain>" // <xxxxxxxx>trial-ga
#globalaccount = "0a206e29trial-ga" // jgl-sap
globalaccount = "2e243346trial-ga" // jgl-vod

# Region for your trial subaccount
region = "us10"

# Name of your sub account
#subaccount_id = "<your trial Subaccount ID>"
#subaccount_id = "60930557-ac56-4bd8-bde2-1ec35e65d4c5" // jgl-sap
subaccount_id = "ca7d9286-b034-4137-b37b-60a79dc22d34" // jgl-vod

# ------------------------------------------------------------------------------------------------------
# Use case specific configurations
# ------------------------------------------------------------------------------------------------------
#abap_admin_email = "you@your.company.com"
abap_admin_email = "jens.glander@vodafone.de"

# This TF script allows you to create a CF space but carefully check conditions
# create_cf_space must be false, if CF is enabled and a space with the configured space name already exists
#
# create_cf_space = true // false (default)

# ------------------------------------------------------------------------------------------------------
# Create tfvars file for the step 2
# ------------------------------------------------------------------------------------------------------
create_tfvars_file_for_step2 = true