variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain where the sub account shall be created."
}
 
variable "cli_server_url" {
  type        = string
  description = "The BTP CLI server URL."
  default     = "https://cpcli.cf.eu10.hana.ondemand.com"
}

variable "custom_idp_origin" {
    type = string
}

variable "cf_api_url" {
    type = string
}

variable "cf_landscape_label" {
    type = string
}

variable "cf_org_id" {
    type = string
}

variable "subaccount_id" {
    type = string
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
