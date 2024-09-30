# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
# Your global account subdomain
globalaccount = "d99367batrial-ga" // <xxxxxxxx>trial-ga

# Name of your sub account
#subaccount_id = "18446fd8-0f61-43eb-abb9-a9b65fd03c90" // trial (default)
subaccount_id = "3ec3e45b-4540-4841-83a1-2e4d9c3d7c46" // mytrial


# Region for your trial subaccount (create subaccount scenario when subaccount id is empty)
#region = "us10"

# ------------------------------------------------------------------------------------------------------
# Use case specific configurations
# ------------------------------------------------------------------------------------------------------
abap_admin_email = "jens.glander@vodafone.de"

cf_org_managers     = ["jens.glander@vodafone.de"]
cf_org_users        = ["jens.glander@vodafone.de"]
cf_space_managers   = ["jens.glander@vodafone.de"]
cf_space_developers = ["jens.glander@vodafone.de"]

# This TF script allows you to create a CF space but carefully check conditions
# create_cf_space must be false, if CF is enabled and a space with the configured space name already exists
#
# create_cf_space = true // false (default)

# ------------------------------------------------------------------------------------------------------
# Create tfvars file for the step 2
# ------------------------------------------------------------------------------------------------------
create_tfvars_file_for_step2 = true

#use_optional_resources = true