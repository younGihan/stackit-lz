# ── meshStack trigger context ────────────────────────────────────────────────
# Populated by the meshStack building block runner (or passed via -var for manual runs).

variable "workspace_identifier" {
  type        = string
  nullable    = false
  description = "meshStack workspace identifier that owns the meshProject this STACKIT project is created for."
}

variable "project_name" {
  type        = string
  nullable    = false
  description = "Name of the meshProject this run is triggered for. Also used as the STACKIT project name."
}

# ── Environment / SNA selection ──────────────────────────────────────────────

variable "environment_tag_name" {
  type        = string
  default     = "environment"
  nullable    = false
  description = "Name of the meshProject tag whose value ('prod', 'qa' or 'test') selects which SNA the project is placed in."
}

variable "sna_network_area_ids" {
  type        = map(string)
  nullable    = false
  description = "STACKIT Network Area (SNA) ID for each environment. Must contain exactly the keys \"prod\", \"qa\" and \"test\"."

  validation {
    condition     = alltrue([for k in ["prod", "qa", "test"] : contains(keys(var.sna_network_area_ids), k)])
    error_message = "sna_network_area_ids must define an entry for each of \"prod\", \"qa\" and \"test\"."
  }
}

variable "network_base_cidrs" {
  type        = map(string)
  nullable    = false
  description = "Supernet CIDR each environment's SNA carves new network ranges from (e.g. { prod = \"10.10.0.0/16\" }). Only used when var.network_range_override is not set. Must contain exactly the keys \"prod\", \"qa\" and \"test\"."

  validation {
    condition     = alltrue([for k in ["prod", "qa", "test"] : contains(keys(var.network_base_cidrs), k)])
    error_message = "network_base_cidrs must define an entry for each of \"prod\", \"qa\" and \"test\"."
  }
}

variable "network_prefix_length" {
  type        = number
  default     = 24
  nullable    = false
  description = "Prefix length of the network range allocated to the project within the SNA (e.g. 24 for a /24)."
}

variable "network_range_override" {
  type        = string
  default     = null
  description = "Set to an existing CIDR (e.g. \"10.10.2.0/24\") to reuse it for this project instead of computing and adding a new one. Must already be one of the SNA's ranges, or a free range within the environment's network_base_cidrs supernet."
}

# ── STACKIT project ───────────────────────────────────────────────────────────

variable "stackit_organization_id" {
  type        = string
  nullable    = false
  description = "STACKIT organization ID that owns the SNAs and the parent container."
}

variable "stackit_parent_container_id" {
  type        = string
  nullable    = false
  description = "STACKIT resource manager container ID (organization or folder) the project is created under."
}

variable "stackit_owner_email" {
  type        = string
  nullable    = false
  description = "Email address of the STACKIT project owner."
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
  description = "STACKIT region used for region-scoped resources (network area region, project network)."
}

variable "additional_project_labels" {
  type        = map(string)
  default     = {}
  nullable    = false
  description = "Extra labels merged onto the STACKIT project, in addition to the networkArea label this template sets automatically."
}
