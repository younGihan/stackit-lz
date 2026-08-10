data "meshstack_project" "this" {
  metadata = {
    name               = var.project_name
    owned_by_workspace = var.workspace_identifier
  }
}

# Only actually read once the environment tag resolved to a known SNA - see locals.tf.
# Reading it here lets us discover its currently registered network ranges so we can
# compute the next free block without clobbering ranges other projects already added.
data "stackit_network_area_region" "selected" {
  count = local.selected_network_area_id != null ? 1 : 0

  organization_id = var.stackit_organization_id
  network_area_id = local.selected_network_area_id
  region          = var.stackit_region
}
