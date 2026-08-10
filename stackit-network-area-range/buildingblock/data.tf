# Assumes the SNA's region already exists - if it doesn't, this fails with "Region configuration
# for ... does not exist." Run ../../stackit-network-area-bootstrap first.
data "stackit_network_area_region" "selected" {
  organization_id = var.organization_id
  network_area_id = var.network_area_id
  region          = var.stackit_region
}
