# Extends the SNA's region with the newly computed (or reused, via network_range_override) range.
# Passes through every other ipv4 setting unchanged from the current state so this run only ever
# adds a range - it never resets transfer_network, nameservers or prefix bounds.
#
# NOTE: this resource manages the region's *entire* range list. Two orders against the same SNA
# running concurrently can race and overwrite each other's newly added range - serialize applies
# per SNA if that's a risk in your setup.
resource "stackit_network_area_region" "selected" {
  organization_id = var.organization_id
  network_area_id = var.network_area_id
  region          = var.stackit_region

  ipv4 = {
    network_ranges        = [for prefix in local.network_ranges_final : { prefix = prefix }]
    transfer_network      = data.stackit_network_area_region.selected.ipv4.transfer_network
    min_prefix_length     = data.stackit_network_area_region.selected.ipv4.min_prefix_length
    max_prefix_length     = data.stackit_network_area_region.selected.ipv4.max_prefix_length
    default_prefix_length = data.stackit_network_area_region.selected.ipv4.default_prefix_length
    default_nameservers   = length(data.stackit_network_area_region.selected.ipv4.default_nameservers) > 0 ? data.stackit_network_area_region.selected.ipv4.default_nameservers : null
  }
}
