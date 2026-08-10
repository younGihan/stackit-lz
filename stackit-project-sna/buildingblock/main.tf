resource "stackit_resourcemanager_project" "this" {
  parent_container_id = var.stackit_parent_container_id
  name                = local.stackit_project_name
  owner_email         = var.stackit_owner_email
  labels              = length(local.project_labels) > 0 ? local.project_labels : null

  lifecycle {
    precondition {
      condition     = local.selected_network_area_id != null
      error_message = "meshProject '${var.project_name}' has no usable environment. Tag it with '${var.environment_tag_name}' set to one of: ${join(", ", keys(var.sna_network_area_ids))} (current value: '${coalesce(local.environment, "<missing>")}')."
    }
  }
}
