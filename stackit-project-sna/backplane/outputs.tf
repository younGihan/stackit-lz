output "building_block_definition_uuid" {
  value       = meshstack_building_block_definition.stackit_project_sna.metadata.uuid
  description = "UUID of the registered STACKIT Project on SNA building block definition."
}

output "building_block_definition_version_uuid" {
  value       = var.bbd_draft ? meshstack_building_block_definition.stackit_project_sna.version_latest.uuid : meshstack_building_block_definition.stackit_project_sna.version_latest_release.uuid
  description = "UUID of the version to order instances against."
}
