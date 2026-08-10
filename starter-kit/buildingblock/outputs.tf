output "qa_building_block_status" {
  value       = meshstack_building_block.qa.status.status
  description = "Execution status of the qa building block instance."
}

output "prod_building_block_status" {
  value       = meshstack_building_block.prod.status.status
  description = "Execution status of the prod building block instance."
}
