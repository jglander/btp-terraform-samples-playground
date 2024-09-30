# Description: This file contains the input variables for step 2

# The globalaccount subdomain where the sub account shall be created.
variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain where the sub account shall be created."
}

variable "cli_server_url" {
  type        = string
  description = "The BTP CLI server URL."
  default     = "https://cli.btp.cloud.sap"
}

# ------------------------------------------------------------------------------------------------------
# use case specific variables
# ------------------------------------------------------------------------------------------------------
variable "abap_admin_email" {
  type        = string
  description = "Email of the ABAP Administrator."
}

# ------------------------------------------------------------------------------------------------------
# ENVIRONMENTS (user lists and other vars)
# ------------------------------------------------------------------------------------------------------
# cloudfoundry (Cloud Foundry Environment)
# ------------------------------------------------------------------------------------------------------
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
variable "cf_api_url" {
  type        = string
  description = "The API endpoint of the Cloud Foundry environment."
}
variable "cf_org_id" {
  type        = string
  description = "The Cloud Foundry landscape (format example eu10-004)."
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
