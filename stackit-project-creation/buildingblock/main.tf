resource "stackit_resourcemanager_project" "this" {
  parent_container_id = var.stackit_parent_container_id
  name                = local.stackit_project_name
  owner_email         = var.stackit_owner_email
  labels              = length(local.project_labels) > 0 ? local.project_labels : null

  lifecycle {
    precondition {
      condition = local.selected_network_area_id != null && (
        local.network_range_override_set || local.selected_base_cidr != null
      )
      error_message = "meshProject '${var.project_name}' has no usable environment. Tag it with '${var.environment_tag_name}' set to one of: ${join(", ", keys(var.sna_network_area_ids))} (current value: '${coalesce(local.environment, "<missing>")}'), or set network_range_override together with a matching entry in sna_network_area_ids."
    }
  }
}

# Extends the environment's SNA with the newly computed (or reused, via network_range_override)
# network range. Passes through every other ipv4 setting unchanged from the current state so this
# run only ever adds a range - it never resets transfer_network, nameservers or prefix bounds.
#
# NOTE: this resource manages the SNA region's *entire* range list. Two project creations for the
# same environment running concurrently can race and overwrite each other's newly added range -
# serialize applies per environment (e.g. via a Terraform workspace/state lock per SNA) if that's
# a risk in your setup.
resource "stackit_network_area_region" "selected" {
  count = local.selected_network_area_id != null ? 1 : 0

  organization_id = var.stackit_organization_id
  network_area_id = local.selected_network_area_id
  region          = var.stackit_region

  ipv4 = {
    network_ranges        = [for prefix in local.network_ranges_final : { prefix = prefix }]
    transfer_network      = local.existing_region.transfer_network
    min_prefix_length     = local.existing_region.min_prefix_length
    max_prefix_length     = local.existing_region.max_prefix_length
    default_prefix_length = local.existing_region.default_prefix_length
    default_nameservers   = length(local.existing_region.default_nameservers) > 0 ? local.existing_region.default_nameservers : null
  }
}

# The project's own network, carved out of the range that was just added to (or reused from) the SNA.
resource "stackit_network" "project_network" {
  count = local.selected_network_area_id != null ? 1 : 0

  project_id  = stackit_resourcemanager_project.this.project_id
  name        = "${local.stackit_project_name}-network"
  ipv4_prefix = local.selected_network_range
  routed      = true

  depends_on = [stackit_network_area_region.selected]
}
