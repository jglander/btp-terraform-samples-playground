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
    condition     = contains(["free", "standard"], var.service_env_plan__cloudfoundry)
    error_message = "Invalid value for service_env_plan__cloudfoundry. Only 'free' and 'standard' are allowed."
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
