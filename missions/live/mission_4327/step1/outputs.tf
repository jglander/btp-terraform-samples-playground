output "globalaccount" {
  value       = var.globalaccount
  description = "The globalaccount subdomain."
}

output "cli_server_url" {
  value       = var.cli_server_url
  description = "The BTP CLI server URL."
}

output "subaccount_id" {
  value = btp_subaccount.project.id
}

output "cf_landscape_label" {
  value = terraform_data.cf_landscape_label.output
}

output "cf_org_id" {
  value = btp_subaccount_environment_instance.cloudfoundry.platform_id
}

output "cf_api_url" {
  value = lookup(jsondecode(btp_subaccount_environment_instance.cloudfoundry.labels), "API Endpoint", "not found")
}
