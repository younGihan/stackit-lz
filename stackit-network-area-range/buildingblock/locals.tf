locals {
  existing_prefixes = [for r in data.stackit_network_area_region.selected.ipv4.network_ranges : r.prefix]

  # IPv4 CIDR -> 32-bit integer, so we can compare addresses arithmetically.
  base_cidr_parts = split("/", var.network_base_cidr)
  base_prefix_len = tonumber(local.base_cidr_parts[1])
  base_ip_int     = sum([for idx, octet in split(".", local.base_cidr_parts[0]) : tonumber(octet) * pow(256, 3 - idx)])
  block_size      = pow(2, 32 - var.network_prefix_length)

  existing_ip_ints = [
    for p in local.existing_prefixes :
    sum([for idx, octet in split(".", split("/", p)[0]) : tonumber(octet) * pow(256, 3 - idx)])
  ]

  # Index (within the supernet) of each existing range, so the next one continues the sequence
  # (…, 10.10.3.0/24 -> 10.10.4.0/24) instead of just filling the first gap.
  existing_indices = [
    for n in local.existing_ip_ints : floor((n - local.base_ip_int) / local.block_size) if n >= local.base_ip_int
  ]

  next_index = length(local.existing_indices) > 0 ? max(local.existing_indices...) + 1 : 0

  computed_network_range = cidrsubnet(var.network_base_cidr, var.network_prefix_length - local.base_prefix_len, local.next_index)

  # A ternary only evaluates its taken branch, unlike && (which evaluates both sides in HCL) or
  # coalesce(x, "") (which errors when every argument, including the "" fallback, is empty/null).
  network_range_override_set = var.network_range_override != null ? trimspace(var.network_range_override) != "" : false

  selected_network_range = local.network_range_override_set ? var.network_range_override : local.computed_network_range

  # Full desired range list: existing ranges plus the selected one. distinct() makes reusing an
  # already-registered range (via network_range_override) a no-op.
  network_ranges_final = distinct(concat(local.existing_prefixes, [local.selected_network_range]))
}
