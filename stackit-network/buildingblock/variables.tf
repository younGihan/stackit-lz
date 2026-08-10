# ── meshStack trigger context ────────────────────────────────────────────────

variable "project_id" {
  type        = string
  nullable    = false
  description = "STACKIT project ID of the target tenant, auto-derived from the target tenant's platform_tenant_id."
}

# ── Per-order inputs ──────────────────────────────────────────────────────────

variable "network_name" {
  type        = string
  nullable    = false
  description = "Name of the STACKIT network to create."
}

variable "network_prefix_length" {
  type        = number
  default     = 24
  nullable    = false
  description = "IPv4 prefix length for the network (24-29). STACKIT auto-allocates a free block of this size from the project's SNA."

  validation {
    condition     = var.network_prefix_length >= 24 && var.network_prefix_length <= 29
    error_message = "network_prefix_length must be between 24 and 29."
  }
}

variable "routed" {
  type        = bool
  default     = true
  nullable    = false
  description = "If true, the network is routed and therefore accessible from other networks in the same SNA."
}

variable "ipv4_nameservers" {
  type        = list(string)
  default     = []
  nullable    = false
  description = "IPv4 nameservers for the network. Empty list falls back to the project's SNA default nameservers."
}

# ── STACKIT platform configuration ──────────────────────────────────────────

variable "stackit_service_account_email" {
  type        = string
  nullable    = false
  description = "Email of the STACKIT service account used for Workload Identity Federation (OIDC) authentication."
}

variable "stackit_region" {
  type        = string
  default     = "eu01"
  nullable    = false
  description = "STACKIT region passed to the provider configuration and used for the network."
}
