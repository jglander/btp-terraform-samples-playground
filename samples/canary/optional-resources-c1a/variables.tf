variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain where the sub account shall be created."
}
 
variable "cli_server_url" {
  type        = string
  description = "The BTP CLI server URL."
  default     = "https://cli.btp.cloud.sap/"
}
 
variable "custom_idp" {
  type        = string
  description = "Defines the custom IDP to be used for the subaccount"
  default     = "" 
}

variable "region" {
  type        = string
  description = "The region where the sub account shall be created in."
  default     = "us10"
}

variable "subaccount_name" {
  type        = string
  description = "The subaccount name"
  default     = "New Sample Subaccount"
}

variable "subaccount_id" {
  type        = string
  description = "The subaccount ID"
  default     = ""
}

variable "use_optional_resources" {
  type        = bool
  description = "optional resources are ignored if value is false"
  default     = true
}

variable "service_plan__sap_launchpad" {
  type        = string
  description = "The plan for service 'SAP Build Work Zone, standard edition' with technical name 'SAPLaunchpad'"
  default     = "free"
  validation {
    condition     = contains(["foundation", "free", "standard"], var.service_plan__sap_launchpad)
    error_message = "Invalid value for service_plan__sap_launchpad. Only 'foundation', 'free' and 'standard' are allowed."
  }
}

variable "service_plan__destination" {
  type        = string
  description = "The plan for service 'Destination Service' with technical name 'destination'"
  default     = "admin"
  validation {
    condition     = contains(["admin", "free"], var.service_plan__destination)
    error_message = "Invalid value for service_plan__destination. Only 'admin' and 'free' are allowed."
  }
}

variable "service_plan__aicore" {
  type        = string
  description = "The plan for service 'SAP AI Core' with technical name 'aicore'"
  default     = "free"
  validation {
    condition     = contains(["extended", "free", "standard", "sap-internal"], var.service_plan__aicore)
    error_message = "Invalid value for service_plan__aicore. Only 'extended', 'free', 'standard' and 'sap-internal' are allowed."
  }
}

variable "service_plan__application_runtime" {
  type        = string
  description = "The plan for service 'Cloud Foundry Runtime' with technical name 'APPLICATION_RUNTIME'"
  default     = "MEMORY"

  validation {
    condition     = contains(["MEMORY"], var.service_plan__application_runtime)
    error_message = "Invalid value for service_plan__application_runtime. Only 'MEMORY' is allowed."
  }
}

variable "service_plan__sap_build_apps" {
  type        = string
  description = "The plan for service 'SAP Build Apps' with technical name 'sap-build-apps'"
  default     = "free"
  validation {
    condition     = contains(["community", "free", "partner", "standard"], var.service_plan__sap_build_apps)
    error_message = "Invalid value for service_plan__sap_build_apps. Only 'community', 'free', 'partner' and 'standard' are allowed."
  }
}

variable "service_plan__canary_saas" {
  type        = string
  description = "The plan for service 'SAP Business Application Studio' with technical name 'canary-saas'"
  default     = "free"
  validation {
    condition     = contains(["build-code", "build-code-free", "free", "standard"], var.service_plan__canary_saas)
    error_message = "Invalid value for service_plan__canary_saas. Only 'build-code', 'build-code-free', 'free' and 'standard' are allowed."
  }
}
