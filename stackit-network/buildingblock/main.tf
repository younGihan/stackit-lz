# ipv4_prefix (not set here) lets STACKIT auto-allocate a free block of ipv4_prefix_length from
# the project's SNA - no manual CIDR bookkeeping needed.
resource "stackit_network" "this" {
  project_id         = var.project_id
  name               = var.network_name
  ipv4_prefix_length = var.network_prefix_length
  ipv4_nameservers   = length(var.ipv4_nameservers) > 0 ? var.ipv4_nameservers : null
  routed             = var.routed
}
