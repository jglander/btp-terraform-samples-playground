variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain where the sub account shall be created."
}
 
variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = "My test subaccount"
}
 
variable "cli_server_url" {
  type        = string
  description = "The BTP CLI server URL."
  default     = "https://cpcli.cf.eu10.hana.ondemand.com"
}

variable "custom_idp" {
  type = string
  default = ""
}
 
variable "region" {
  type        = string
  description = "The region where the sub account shall be created in."
  default     = "eu12"
}

variable "cf_org_name" {
  type        = string
  description = "Name of the Cloud Foundry org."
  default     = "qas sample - cf_multi_step"

  validation {
    condition     = can(regex("^.{1,255}$", var.cf_org_name))
    error_message = "The Cloud Foundry org name must not be empty and not exceed 255 characters."
  }
}
