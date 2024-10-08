# ------------------------------------------------------------------------------------------------------
# Account variables
# ------------------------------------------------------------------------------------------------------
variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain where the sub account shall be created."
}

variable "cli_server_url" {
  type        = string
  description = "The BTP CLI server URL."
  default     = "https://cli.btp.cloud.sap"
}

variable "custom_idp" {
  type        = string
  description = "The custom identity provider for the subaccount."
  default     = ""
}

variable "region" {
  type        = string
  description = "The region where the subaccount shall be created in."
  default     = "us10"
}

variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = ""
}

variable "subaccount_id" {
  type        = string
  description = "The subaccount ID."
  default     = ""
}

# user lists
variable "subaccount_admins" {
  type        = list(string)
  description = "Defines the colleagues who are added to subaccount as administrator"
}

variable "subaccount_service_admins" {
  type        = list(string)
  description = "Defines the colleagues who are added to subaccount as service administrator"
}

# ------------------------------------------------------------------------------------------------------
# Switch for creating tfvars for step 2
# ------------------------------------------------------------------------------------------------------
variable "create_tfvars_file_for_step2" {
  type        = bool
  description = "Switch to enable the creation of the tfvars file for step 2."
  default     = false
}

# ------------------------------------------------------------------------------------------------------
# use case specific variables
# ------------------------------------------------------------------------------------------------------
variable "use_optional_resources" {
  type        = bool
  description = "optional resources are ignored if value is false"
  default     = true
}

# ------------------------------------------------------------------------------------------------------
# ENVIRONMENTS (plans, user lists and other vars)
# ------------------------------------------------------------------------------------------------------
# cloudfoundry (Cloud Foundry Environment)
# ------------------------------------------------------------------------------------------------------
# plans
variable "service_env_plan__cloudfoundry" {
  type        = string
  description = "The plan for service environment 'Cloud Foundry Environment' with technical name 'cloudfoundry'"
  default     = "standard"
  validation {
    condition     = contains(["standard"], var.service_env_plan__cloudfoundry)
    error_message = "Invalid value for service_env_plan__cloudfoundry. Only 'standard' is allowed."
  }
}

# user lists
variable "cf_org_managers" {
  type        = list(string)
  description = "List of managers for the Cloud Foundry org."
}

variable "cf_org_users" {
  type        = list(string)
  description = "List of users for the Cloud Foundry org."
}

variable "cf_space_managers" {
  type        = list(string)
  description = "List of managers for the Cloud Foundry space."
}

variable "cf_space_developers" {
  type        = list(string)
  description = "List of developers for the Cloud Foundry space."
}

# cf landscape, org, space variables
variable "cf_landscape_label" {
  type        = string
  description = "In case there are multiple environments available for a subaccount, you can use this label to choose with which one you want to go. If nothing is given, we take by default the first available."
  default     = ""
}

variable "cf_org_name" {
  type        = string
  description = "Name of the Cloud Foundry org."
  default     = ""
}

variable "cf_space_name" {
  type        = string
  description = "Name of the Cloud Foundry space."
  default     = "dev"

  validation {
    condition     = can(regex("^.{1,255}$", var.cf_space_name))
    error_message = "The Cloud Foundry space name must not be emtpy and not exceed 255 characters."
  }
}

# ------------------------------------------------------------------------------------------------------
# SERVICES (plans and other parameters)
# ------------------------------------------------------------------------------------------------------
# analytics-planning-osb (SAP Analytics Cloud)
# ------------------------------------------------------------------------------------------------------
# plans
variable "service_plan__sap_analytics_cloud" {
  type        = string
  description = "The plan for service 'SAP Analytics Cloud' with technical name 'analytics-planning-osb'"
  default     = "free"
  validation {
    condition     = contains(["free", "production"], var.service_plan__sap_analytics_cloud)
    error_message = "Invalid value for service_plan__sap_analytics_cloud. Only 'free' and 'production' are allowed."
  }
}

# sap analytics cloud (sac) instance parameters
variable "sac_admin_email" {
  type        = string
  description = "SAC Admin Email"
}

variable "sac_admin_first_name" {
  type        = string
  description = "SAC Admin First Name"
  default     = "first name"
}

variable "sac_admin_last_name" {
  type        = string
  description = "SAC Admin Last Name"
  default     = "last name"
}

variable "sac_admin_host_name" {
  type        = string
  description = "SAC Admin Host Name"
  default     = ""
}

variable "sac_number_of_business_intelligence_licenses" {
  type        = number
  description = "Number of business intelligence licenses"
  default     = 25
}

variable "sac_number_of_professional_licenses" {
  type        = number
  description = "Number of business professional licenses"
  default     = 1
}

variable "sac_number_of_business_standard_licenses" {
  type        = number
  description = "Number of business standard licenses"
  default     = 10
}

# testing
variable "is_service_setup_enabled__sac" {
  type        = bool
  description = "If true setup of app subscription 'SAP Analytics Cloud' with technical name 'analytics-planning-osb' is enabled"
  default     = false
}

# ------------------------------------------------------------------------------------------------------
# APP SUBSCRIPTIONS (plans and user lists)
# ------------------------------------------------------------------------------------------------------
# SAPLaunchpad (SAP Build Work Zone, standard edition)
# ------------------------------------------------------------------------------------------------------
# plans
variable "app_subscription_plan__sap_launchpad" {
  type        = string
  description = "The plan for app subscription 'SAP Build Work Zone, standard edition' with technical name 'SAPLaunchpad'"
  default     = "free"
  validation {
    condition     = contains(["free", "standard"], var.app_subscription_plan__sap_launchpad)
    error_message = "Invalid value for app_subscription_plan__sap_launchpad. Only 'free' and 'standard' are allowed."
  }
}

# user lists
variable "launchpad_admins" {
  type        = list(string)
  description = "Defines the colleagues who are Launchpad Admins."
}

# testing
variable "is_service_setup_enabled__sap_launchpad" {
  type        = bool
  description = "If true setup of app subscription 'SAP Build Work Zone, standard edition' with technical name 'SAPLaunchpad' is enabled"
  default     = false
}


