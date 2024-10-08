output "subaccount_id" {
  value       = data.btp_subaccount.project.id
  description = "The ID of the project subaccount."
}

output "sapappstudio_subscription_url" {
  value       = data.btp_subaccount_subscription.sapappstudio.subscription_url
  description = "SAP Business Application Studio subscription URL."
}

output "sap_launchpad_subscription_url" {
  value       = btp_subaccount_subscription.sap_launchpad.subscription_url
  description = "SAP Build Work Zone, standard edition subscription URL."
}
