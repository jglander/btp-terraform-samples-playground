variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain where the sub account shall be created."
}
 
variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = "my new subacc name"
}

variable "subaccount_id" {
  type        = string
  description = "The subaccount ID."
  default     = ""
}
 
variable "cli_server_url" {
  type        = string
  description = "The BTP CLI server URL."
  default     = "https://cli.btp.cloud.sap/"
}
 
variable "custom_idp" {
  type        = string
  description = "Defines the custom IDP to be used for the subaccount"
  default = "" 
}
 
variable "region" {
  type        = string
  description = "The region where the sub account shall be created in."
  default     = "us10"
}

variable "service_plan__cf_runtime" {
  type        = string
  description = "The plan for cf runtime"
  default     = "MEMORY"
  validation {
    condition     = contains(["MEMORY"], var.service_plan__cf_runtime)
    error_message = "Invalid value for service_plan__cf_runtime. Only 'MEMORY' is allowed."
  }
}

