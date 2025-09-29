terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "1.16.1"
    }
  }
}

######################################################################
# Configure BTP provider
######################################################################
provider "btp" {
  cli_server_url = var.cli_server_url
  #idp            = var.custom_idp
  globalaccount  = var.globalaccount
}