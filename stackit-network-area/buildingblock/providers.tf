provider "stackit" {
  default_region        = var.stackit_region
  service_account_email = var.stackit_service_account_email
  use_oidc              = true

  # The STACKIT provider's own default WIF token path
  # (/var/run/secrets/stackit.cloud/serviceaccount/token) doesn't exist in meshStack's building
  # block runner - it mounts the OIDC token here instead.
  service_account_federated_token_path = "/var/run/secrets/workload-identity/azure/token"
}
