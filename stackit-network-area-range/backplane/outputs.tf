output "building_block_definition_uuid" {
  value       = meshstack_building_block_definition.stackit_network_area_range.metadata.uuid
  description = "UUID of the registered STACKIT Network Area Range building block definition."
}

output "building_block_definition_version_uuid" {
  value       = var.bbd_draft ? meshstack_building_block_definition.stackit_network_area_range.version_latest.uuid : meshstack_building_block_definition.stackit_network_area_range.version_latest_release.uuid
  description = "UUID of the version to order instances against."
}
