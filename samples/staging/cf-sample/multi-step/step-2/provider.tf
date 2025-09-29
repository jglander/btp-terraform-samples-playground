terraform {
  required_providers {
    cloudfoundry = {
      source  = "cloudfoundry/cloudfoundry"
      version = "1.8.0"
    }
  }
}

######################################################################
# Configure CF provider
######################################################################
provider "cloudfoundry" {
    # resolve API URL from environment instance
    api_url = var.cf_api_url
}