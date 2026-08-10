data "meshstack_project" "this" {
  metadata = {
    name               = var.project_name
    owned_by_workspace = var.workspace_identifier
  }
}
