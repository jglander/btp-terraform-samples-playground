output "subaccount_id" {
  value       = data.btp_subaccount.dc_mission.id
  description = "The ID of the project subaccount."
}

output "auditlog_viewer_apps_subscription_url" {
  value       = btp_subaccount_subscription.auditlog_viewer.subscription_url
  description = "Audit Log Viewer subscription URL."
}

output "automationpilot_subscription_url" {
  value       = var.use_optional_resources ? btp_subaccount_subscription.automationpilot[0].subscription_url : null
  description = "Automation Pilot subscription URL."
}
