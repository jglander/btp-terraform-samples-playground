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
  default     = "us10"
}