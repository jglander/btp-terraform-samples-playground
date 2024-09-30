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

variable "region" {
  type        = string
  description = "The region where the subaccount shall be created in."
  default     = "us10"
}

variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = "My SAP DC mission trial subaccount."
}

variable "subaccount_id" {
  type        = string
  description = "The ID of the trial subaccount."
  default     = ""
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
  default     = false
}

variable "abap_admin_email" {
  type        = string
  description = "Email of the ABAP Administrator."
  default     = ""
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
  default     = "trial"
  validation {
    condition     = contains(["trial"], var.service_env_plan__cloudfoundry)
    error_message = "Invalid value for service_env_plan__cloudfoundry. Only 'trial' is allowed."
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

# related variables
variable "create_cf_space" {
  type        = bool
  description = "Determines whether a new CF space should be created. Must be true if no space with the given name exists for the org, false otherwise. If CF isn't enabled for no subaccount a new space will always be created"
  default     = false
}

variable "cf_space_name" {
  type        = string
  description = "The name of the CF space to use."
  default     = "dev"
}

# ------------------------------------------------------------------------------------------------------
# SERVICES (plans)
# ------------------------------------------------------------------------------------------------------
# abap-trial (ABAP environment)
# ------------------------------------------------------------------------------------------------------
# plans
variable "service_plan__abap_trial" {
  type        = string
  description = "The plan for service 'ABAP environment' with technical name 'abap-trial'"
  default     = "shared"
  validation {
    condition     = contains(["shared"], var.service_plan__abap_trial)
    error_message = "Invalid value for service_plan__abap_trial. Only 'shared' is allowed."
  }
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
  default     = "standard"
  validation {
    condition     = contains(["standard"], var.app_subscription_plan__sap_launchpad)
    error_message = "Invalid value for app_subscription_plan__sap_launchpad. Only 'standard' is allowed."
  }
}

# ------------------------------------------------------------------------------------------------------
# cicd-app (SAP Continuous Integration and Delivery)
# ------------------------------------------------------------------------------------------------------
# plans
variable "app_subscription_plan__cicd_app" {
  type        = string
  description = "The plan for app subscription 'SAP Continuous Integration and Delivery' with technical name 'cicd-app'"
  default     = "trial"
  validation {
    condition     = contains(["trial"], var.app_subscription_plan__cicd_app)
    error_message = "Invalid value for app_subscription_plan__cicd_app. Only 'trial' are allowed."
  }
}

# ------------------------------------------------------------------------------------------------------
# sapappstudiotrial (SAP Business Application Studio)
# ------------------------------------------------------------------------------------------------------
# plans
variable "app_subscription_plan__sapappstudiotrial" {
  type        = string
  description = "The plan for app subscription 'SAP Business Application Studio' with technical name 'sapappstudiotrial'"
  default     = "trial"
  validation {
    condition     = contains(["trial"], var.app_subscription_plan__sapappstudiotrial)
    error_message = "Invalid value for app_subscription_plan__sapappstudiotrial. Only 'trial' are allowed."
  }
}
