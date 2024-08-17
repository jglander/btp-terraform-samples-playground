locals {
  # NOTE: Canary/Live: service_name  = "canary-saas"/"sapappstudio" and plan_name = "standard" / "standard-edition"
  service__sap_business_app_studio    = "canary-saas"
  service_name__sap_integration_suite = "integrationsuite"

  int_provisioners = var.use_optional_resources == true ? var.int_provisioners : []
}