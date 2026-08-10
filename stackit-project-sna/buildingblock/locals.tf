locals {
  environment_raw = try(data.meshstack_project.this.spec.tags[var.environment_tag_name][0], null)
  environment     = local.environment_raw != null ? lower(local.environment_raw) : null

  selected_network_area_id = local.environment != null ? lookup(var.sna_network_area_ids, local.environment, null) : null

  # <workspaceID>.<projectID>.<env> - falls back to "unknown" for the env segment when the
  # environment tag is missing/unmapped, so this stays a valid string; the precondition on
  # stackit_resourcemanager_project.this (main.tf) is what actually blocks that case from applying.
  stackit_project_name = "${var.workspace_identifier}.${var.project_name}.${coalesce(local.environment, "unknown")}"

  project_labels = merge(
    var.additional_project_labels,
    local.selected_network_area_id != null ? { networkArea = local.selected_network_area_id } : {}
  )
}
