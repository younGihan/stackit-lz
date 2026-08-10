locals {
  environment_raw = try(data.meshstack_project.this.spec.tags[var.environment_tag_name][0], null)
  environment     = local.environment_raw != null ? lower(local.environment_raw) : null

  selected_network_area_id = local.environment != null ? lookup(var.sna_network_area_ids, local.environment, null) : null
  selected_base_cidr       = local.environment != null ? lookup(var.network_base_cidrs, local.environment, null) : null

  # <workspaceID>.<projectID>.<env> - falls back to "unknown" for the env segment when the
  # environment tag is missing/unmapped, so this stays a valid string; the precondition on
  # stackit_resourcemanager_project.this (main.tf) is what actually blocks that case from applying.
  stackit_project_name = "${var.workspace_identifier}.${var.project_name}.${coalesce(local.environment, "unknown")}"

  # coalesce(..., "") avoids calling trimspace(null): HCL's && is not short-circuiting, so
  # `var.network_range_override != null && trimspace(var.network_range_override) != ""` would
  # still evaluate trimspace(null) and crash even though the left-hand side is false.
  network_range_override_set = trimspace(coalesce(var.network_range_override, "")) != ""

  # Everything below only needs to resolve when we're actually about to create a project -
  # the precondition on stackit_resourcemanager_project.this (main.tf) is what actually blocks
  # an invalid run; these locals just need to not crash while computing an unused value.

  existing_region   = length(data.stackit_network_area_region.selected) > 0 ? data.stackit_network_area_region.selected[0].ipv4 : null
  existing_ranges   = local.existing_region != null ? local.existing_region.network_ranges : []
  existing_prefixes = [for r in local.existing_ranges : r.prefix]

  # IPv4 CIDR -> 32-bit integer, so we can compare addresses arithmetically.
  base_cidr_parts = local.selected_base_cidr != null ? split("/", local.selected_base_cidr) : null
  base_prefix_len = local.base_cidr_parts != null ? tonumber(local.base_cidr_parts[1]) : null
  base_ip_int     = local.base_cidr_parts != null ? sum([for idx, octet in split(".", local.base_cidr_parts[0]) : tonumber(octet) * pow(256, 3 - idx)]) : null
  block_size      = local.base_prefix_len != null ? pow(2, 32 - var.network_prefix_length) : null

  existing_ip_ints = local.base_ip_int != null ? [
    for p in local.existing_prefixes :
    sum([for idx, octet in split(".", split("/", p)[0]) : tonumber(octet) * pow(256, 3 - idx)])
  ] : []

  # Index (within the environment's supernet) of each existing range, so the next one
  # continues the sequence (…, 10.10.3.0/24 -> 10.10.4.0/24) instead of just filling the first gap.
  existing_indices = local.base_ip_int != null ? [
    for n in local.existing_ip_ints : floor((n - local.base_ip_int) / local.block_size) if n >= local.base_ip_int
  ] : []

  next_index = length(local.existing_indices) > 0 ? max(local.existing_indices...) + 1 : 0

  computed_network_range = local.base_ip_int != null ? cidrsubnet(local.selected_base_cidr, var.network_prefix_length - local.base_prefix_len, local.next_index) : null

  selected_network_range = local.network_range_override_set ? var.network_range_override : local.computed_network_range

  # Full desired range list for the SNA's region: existing ranges plus the selected one.
  # distinct() makes reusing an already-registered range (via network_range_override) a no-op.
  network_ranges_final = local.selected_network_range != null ? distinct(concat(local.existing_prefixes, [local.selected_network_range])) : local.existing_prefixes

  project_labels = merge(
    var.additional_project_labels,
    local.selected_network_area_id != null ? { networkArea = local.selected_network_area_id } : {}
  )
}
