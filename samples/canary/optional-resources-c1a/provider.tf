terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "~> 1.5.0"
    }
  }
}

provider "btp" {
  #idp           = var.custom_idp
  cli_server_url = var.cli_server_url
  globalaccount  = var.globalaccount
}
