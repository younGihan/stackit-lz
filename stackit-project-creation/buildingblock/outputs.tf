output "stackit_project_id" {
  value       = stackit_resourcemanager_project.this.project_id
  description = "UUID of the created STACKIT project."
}

output "stackit_project_name" {
  value       = stackit_resourcemanager_project.this.name
  description = "Name of the created STACKIT project, following <workspaceID>.<projectID>.<env>."
}

output "stackit_project_container_id" {
  value       = stackit_resourcemanager_project.this.container_id
  description = "User-friendly container ID of the created STACKIT project."
}

output "environment" {
  value       = local.environment
  description = "Environment resolved from the meshProject tag."
}

output "network_area_id" {
  value       = local.selected_network_area_id
  description = "ID of the SNA the project was placed in."
}

output "network_range" {
  value       = local.selected_network_range
  description = "CIDR range allocated to this project (newly computed, unless network_range_override was set)."
}

output "network_range_was_computed" {
  value       = !local.network_range_override_set
  description = "True if network_range was computed from existing SNA ranges; false if network_range_override was used instead."
}

output "network_id" {
  value       = length(stackit_network.project_network) > 0 ? stackit_network.project_network[0].network_id : null
  description = "UUID of the project's network."
}
