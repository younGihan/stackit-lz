output "network_id" {
  value       = stackit_network.this.network_id
  description = "UUID of the created STACKIT network."
}

output "network_cidr" {
  value       = stackit_network.this.ipv4_prefixes
  description = "Allocated IPv4 CIDR block(s) of the network."
}
