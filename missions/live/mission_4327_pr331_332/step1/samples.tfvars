# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
# Your global account subdomain
globalaccount = "ticoo"

# ------------------------------------------------------------------------------------------------------
# Project specific configuration (please adapt!)
# ------------------------------------------------------------------------------------------------------
# Subaccount configuration
region          = "us10"
subaccount_name = "cf-org-4327-jgl-2709b"
cf_org_name = "cf-org-4327-jgl-2709b"


# To add extra users to the subaccount, the user running the script becomes the admin, without inclusion in admins.

subaccount_admins = ["jens.glander@vodafone.de"]

#------------------------------------------------------------------------------------------------------
# Entitlements plan update
#------------------------------------------------------------------------------------------------------
# For production use of Business Application Studio, upgrade the plan from the `free-tier` to the appropriate plan e.g standard-edition
# service_plan__bas = "standard-edition"
#-------------------------------------------------------------------------------------------------------
# For production use of Build Workzone, upgrade the plan from the `free-tier` to the appropriate plan e.g standard
service_plan__build_workzone = "standard"
#--------------------------------------------------------------------------------------------------------
# For production use of HANA, upgrade the plan from the `free-tier` to the appropriate plan e.g hana
service_plan__hana_cloud = "hana"
# cicd service plan
cicd_service_plan = "default"

#------------------------------------------------------------------------------------------------------
# Cloud Foundry
#------------------------------------------------------------------------------------------------------
# Choose a unique organization name e.g., based on the global account subdomain and subaccount name

# hana cloud admin users
hana_cloud_admins = ["jens.glander@vodafone.de"]

# Additional Cloud Foundry users
cf_space_developers = ["jens.glander@vodafone.de"]
cf_space_managers   = ["jens.glander@vodafone.de"]
cf_org_admins       = ["jens.glander@vodafone.de"]
cf_org_users        = ["jens.glander@vodafone.de"]

create_tfvars_file_for_next_stage = true