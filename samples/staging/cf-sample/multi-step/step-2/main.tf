######################################################################
# Create space using CF provider
######################################################################
resource "cloudfoundry_space" "dev" {
  name      = var.cf_space_name
  org       = var.cf_org_id
}