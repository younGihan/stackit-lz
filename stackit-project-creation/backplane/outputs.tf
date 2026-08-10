output "building_block_definition_uuid" {
  value       = meshstack_building_block_definition.stackit_project_creation.metadata.uuid
  description = "UUID of the registered STACKIT Project Creation building block definition."
}

output "building_block_definition_version_uuid" {
  value       = var.bbd_draft ? meshstack_building_block_definition.stackit_project_creation.version_latest.uuid : meshstack_building_block_definition.stackit_project_creation.version_latest_release.uuid
  description = "UUID of the version to order instances against. Feed this into ../../starter-kit/backplane's stackit_project_creation_bb_version_uuid variable (or any other consumer)."
}
