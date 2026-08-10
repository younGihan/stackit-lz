output "network_area_id" {
  value       = stackit_network_area.this.network_area_id
  description = "UUID of the created STACKIT network area (SNA)."
}

output "network_area_name" {
  value       = stackit_network_area.this.name
  description = "Name of the created SNA."
}

output "network_area_url" {
  value       = "https://portal.stackit.cloud/network-area/network-areas/${stackit_network_area.this.network_area_id}/overview?organization=${var.organization_id}"
  description = "Deep link URL to access the network area in the STACKIT portal."
}
