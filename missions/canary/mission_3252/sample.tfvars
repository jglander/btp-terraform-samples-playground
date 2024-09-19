# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
custom_idp = "<<tenant-id>>.accounts.ondemand.com"
cli_server_url = "https://canary.cli.btp.int.sap/"
# ------------------------------------------------------------------------------------------------------
# Account settings
# ------------------------------------------------------------------------------------------------------

globalaccount   = "775253e0-3e95-4cde-b005-cdc3688cdc2c"
region          = "us31"
subaccount_name = "3252-jgl-live-1809a"

# ------------------------------------------------------------------------------------------------------
# Use case specific configuration
# ------------------------------------------------------------------------------------------------------
subaccount_admins         = ["jens.glander@vodafone.de"]
subaccount_service_admins = ["jens.glander@vodafone.de"]

# Kyma instance parameters. When set to null, the name will be set to the subaccount subdomain and the
# first available cluster region for the subaccount will be selected.
kyma_instance_parameters = null
/*
kyma_instance_parameters = {
  name            = "my-kyma-environment"
  region          = "eu-central-1"
  machine_type    = "mx5.xlarge"
  auto_scaler_min = 3
  auto_scaler_max = 20
}
*/