output "network_range" {
  value       = local.selected_network_range
  description = "CIDR range added to the SNA (newly computed, unless network_range_override was set)."
}

output "network_range_was_computed" {
  value       = !local.network_range_override_set
  description = "True if network_range was computed from existing SNA ranges; false if network_range_override was used instead."
}
