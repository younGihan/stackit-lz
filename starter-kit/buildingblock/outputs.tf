output "qa_tenant_uuid" {
  value       = meshstack_tenant.qa.ref.uuid
  description = "UUID of the qa tenant the STACKIT Project Creation instance was ordered against."
}

output "prod_tenant_uuid" {
  value       = meshstack_tenant.prod.ref.uuid
  description = "UUID of the prod tenant the STACKIT Project Creation instance was ordered against."
}

output "qa_building_block_status" {
  value       = meshstack_building_block.qa.status.status
  description = "Execution status of the qa building block instance."
}

output "prod_building_block_status" {
  value       = meshstack_building_block.prod.status.status
  description = "Execution status of the prod building block instance."
}
