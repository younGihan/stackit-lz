# meshstack authentication (MESHSTACK_ENDPOINT / MESHSTACK_API_KEY / MESHSTACK_API_SECRET or
# MESHSTACK_API_TOKEN) is injected automatically when this template runs as a meshStack building
# block. For standalone runs, export those environment variables or extend this block.
provider "meshstack" {}

provider "stackit" {
  default_region        = var.stackit_region
  service_account_email = var.stackit_service_account_email
  use_oidc              = true
}
