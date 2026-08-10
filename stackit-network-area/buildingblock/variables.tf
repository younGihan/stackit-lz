variable "network_area_name" {
  type        = string
  nullable    = false
  description = "Name of the STACKIT network area (SNA) to create."
}

variable "organization_id" {
  type        = string
  nullable    = false
  description = "STACKIT organization ID the network area is created under."
}

variable "labels" {
  type        = map(string)
  default     = {}
  nullable    = false
  description = "Labels to apply to the network area."
}

variable "stackit_service_account_email" {
  type        = string
  nullable    = false
  description = "Email of the STACKIT service account used for Workload Identity Federation (OIDC) authentication."
}

variable "stackit_region" {
  type        = string
  default     = "eu01"
  nullable    = false
  description = "STACKIT region passed to the provider configuration."
}
