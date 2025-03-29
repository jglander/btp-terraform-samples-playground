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
  default     = "My SAP DC mission subaccount."
}

variable "subaccount_id" {
  type        = string
  description = "The subaccount ID."
  default     = ""
}

# ------------------------------------------------------------------------------------------------------
# services plans
# ------------------------------------------------------------------------------------------------------
variable "service_plan__sap_identity_services_onboarding" {
  type        = string
  description = "The plan for service 'Cloud Identity Services' with technical name 'sap-identity-services-onboarding'"
  default     = "default"
  validation {
    condition     = contains(["default"], var.service_plan__sap_identity_services_onboarding)
    error_message = "Invalid value for service_plan__sap_identity_services_onboarding. Only 'default' is allowed."
  }
}

# ------------------------------------------------------------------------------------------------------
# app subscriptions plans
# ------------------------------------------------------------------------------------------------------
variable "service_plan__sap_launchpad" {
  type        = string
  description = "The plan for app subscription 'SAP Build Work Zone, standard edition' with technical name 'SAPLaunchpad'"
  default     = "standard"
  validation {
    condition     = contains(["standard"], var.service_plan__sap_launchpad)
    error_message = "Invalid value for service_plan__sap_launchpad. Only 'standard' is allowed."
  }
}

# ------------------------------------------------------------------------------------------------------
# User lists
# ------------------------------------------------------------------------------------------------------
variable "subaccount_admins" {
  type        = list(string)
  description = "Defines the colleagues who are added to each subaccount as emergency administrators."
}

variable "launchpad_admins" {
  type        = list(string)
  description = "Defines the colleagues who are Launchpad Admins."
}

# ------------------------------------------------------------------------------------------------------
# Switch for creating tfvars for step 2
# ------------------------------------------------------------------------------------------------------
variable "create_tfvars_file_for_step2" {
  type        = bool
  description = "Switch to enable the creation of the tfvars file for step 2."
  default     = false
}