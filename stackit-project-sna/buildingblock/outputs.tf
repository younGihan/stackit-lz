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

output "network_area_id" {
  value       = local.selected_network_area_id
  description = "ID of the SNA the project was placed in."
}

output "project_url" {
  value       = "https://portal.stackit.cloud/projects/${stackit_resourcemanager_project.this.project_id}"
  description = "Deep link URL to access the project in the STACKIT portal."
}
