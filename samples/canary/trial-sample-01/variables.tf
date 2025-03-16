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

variable "use_optional_resources" {
  type        = bool
  description = "optional resources are ignored if value is false"
  default     = false
}

# ------------------------------------------------------------------------------------------------------
# service plans
# ------------------------------------------------------------------------------------------------------
variable "service_plan__alert_notification" {
  type        = string
  description = "The plan for service 'Alert Notification' with technical name 'alert-notification'"
  default     = "standard"
  validation {
    condition     = contains(["standard"], var.service_plan__alert_notification)
    error_message = "Invalid value for service_plan__alert_notification. Only 'standard' is allowed."
  }
}

# ------------------------------------------------------------------------------------------------------
# app subscription plans
# ------------------------------------------------------------------------------------------------------
variable "service_plan__automationpilot" {
  type        = string
  description = "The plan for Automation Pilot subscription"
  default     = "free"
  validation {
    condition     = contains(["free"], var.service_plan__automationpilot)
    error_message = "Invalid value for service_plan__automationpilot. Only 'free' is allowed."
  }
}

variable "service_plan__auditlog_viewer" {
  type        = string
  description = "The plan for Workflow Management subscription"
  default     = "free"
  validation {
    condition     = contains(["free"], var.service_plan__auditlog_viewer)
    error_message = "Invalid value for service_plan__auditlog_viewer. Only 'free' is allowed."
  }
}

# ------------------------------------------------------------------------------------------------------
# User lists
# ------------------------------------------------------------------------------------------------------
variable "subaccount_admins" {
  type        = list(string)
  description = "Defines the users who are added to subaccount as administrators."
}
