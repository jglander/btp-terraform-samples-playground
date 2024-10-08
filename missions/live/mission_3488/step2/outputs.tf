# ------------------------------------------------------------------------------------------------------
# services dashboard urls
# ------------------------------------------------------------------------------------------------------
output "sac_service_instance_dashboard_url" {
  value       = var.enable_service_setup__sac ? cloudfoundry_service_instance.sac_si[0].dashboard_url : null
  description = "The dashboard URL of the SAP Cloud Analytics cf service instance"
}
