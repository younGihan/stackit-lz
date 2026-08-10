# Creates the SNA only - it has no region configured yet, so no projects can be placed on it until
# a region (network_ranges, transfer_network) is set up separately for the target STACKIT region.
resource "stackit_network_area" "this" {
  organization_id = var.organization_id
  name            = var.network_area_name
  labels          = length(var.labels) > 0 ? var.labels : null
}
