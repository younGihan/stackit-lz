# ── Per-order inputs ──────────────────────────────────────────────────────────

variable "network_area_id" {
  type        = string
  nullable    = false
  description = "ID of the existing STACKIT Network Area (SNA) to add a range to. Its region must already be configured (see ../../stackit-network-area-bootstrap)."
}

variable "network_base_cidr" {
  type        = string
  nullable    = false
  description = "Supernet the new range is carved from (e.g. \"10.10.0.0/16\"). Only used when network_range_override is not set."
}

variable "network_prefix_length" {
  type        = number
  default     = 24
  nullable    = false
  description = "Prefix length of the range to add (e.g. 24 for a /24)."
}

variable "network_range_override" {
  type        = string
  default     = null
  description = "Set to an existing CIDR (e.g. \"10.10.2.0/24\") to add/reuse it instead of computing the next free block from network_base_cidr."
}

# ── STACKIT platform configuration ──────────────────────────────────────────

variable "organization_id" {
  type        = string
  nullable    = false
  description = "STACKIT organization ID that owns the network area."
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
  description = "STACKIT region the network area's region config is being extended in."
}
