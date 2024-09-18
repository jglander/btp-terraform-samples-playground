output "subaccount_id" {
  value = data.btp_subaccount.dc_mission.id
}

output "kyma_env_instance_dashboard_url" {
  value       = btp_subaccount_environment_instance.kyma.dashboard_url
  description = "The URL of the kyma environment dashboard."
}
