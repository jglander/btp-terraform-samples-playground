
variable "use_optional_resources" {
  type        = bool
  description = "With this parameter it is possible to decide if QAS TF script runs with or w/o all optional resources"
  default     = true
}

variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain where the sub account shall be created."
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

variable "subaccount_admins" {
  type        = list(string)
  description = "Defines the colleagues who are added to each subaccount as emergency administrators."

  # add validation to check if admins contains a list of valid email addresses
  validation {
    condition     = length([for email in var.subaccount_admins : can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", email))]) == length(var.subaccount_admins)
    error_message = "Please enter a valid email address for the subaccount admins."
  }
}

variable "launchpad_admins" {
  type        = list(string)
  description = "Defines the colleagues who are Launchpad Admins."

  # add validation to check if admins contains a list of valid email addresses
  validation {
    condition     = length([for email in var.launchpad_admins : can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", email))]) == length(var.launchpad_admins)
    error_message = "Please enter a valid email address."
  }
}

variable "bas_admins" {
  type        = list(string)
  description = "Defines the colleagues who are admins for SAP Business Application Studio."

  # add validation to check if admins contains a list of valid email addresses
  validation {
    condition     = length([for email in var.bas_admins : can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", email))]) == length(var.bas_admins)
    error_message = "Please enter a valid email address."
  }
}

variable "bas_developers" {
  type        = list(string)
  description = "Defines the colleagues who are developers for SAP Business Application Studio."

  # add validation to check if admins contains a list of valid email addresses
  validation {
    condition     = length([for email in var.bas_developers : can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", email))]) == length(var.bas_developers)
    error_message = "Please enter a valid email address."
  }
}

variable "custom_idp" {
  type        = string
  description = "The custom identity provider for the subaccount."
  default     = "sap.ids"
}
