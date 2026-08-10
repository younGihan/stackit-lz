output "building_block_definition_uuid" {
  value       = meshstack_building_block_definition.starter_kit.metadata.uuid
  description = "UUID of the registered STACKIT QA+Prod Bootstrap building block definition."
}
