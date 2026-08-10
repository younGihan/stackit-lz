# ── meshStack ─────────────────────────────────────────────────────────────────

variable "workspace_identifier" {
  type        = string
  nullable    = false
  description = "meshStack (platform team) workspace that owns this building block definition."
}

# ── Building block definition source ────────────────────────────────────────

variable "bbd_repository_url" {
  type        = string
  nullable    = false
  description = "Git URL of the repository containing the stackit-project-creation building block implementation (this repo, once pushed to your git hosting)."
}

variable "bbd_repository_path" {
  type        = string
  default     = "stackit-project-creation/buildingblock"
  nullable    = false
  description = "Path within bbd_repository_url to the stackit-project-creation module."
}

variable "bbd_ref_name" {
  type        = string
  default     = "main"
  nullable    = false
  description = "Git ref (branch, tag or commit) of bbd_repository_url to run."
}

variable "bbd_draft" {
  type        = bool
  default     = true
  nullable    = false
  description = "Whether the building block definition version is kept in draft mode (draft versions can be changed freely; released versions are immutable)."
}

# ── STACKIT platform configuration ──────────────────────────────────────────
# Baked into the registered building block version as STATIC inputs - identical for every
# STACKIT Project Creation instance ordered against it. Only project_name varies per instance.

variable "stackit_organization_id" {
  type        = string
  nullable    = false
  description = "STACKIT organization ID that owns the SNAs and the parent container."
}

variable "stackit_parent_container_id" {
  type        = string
  nullable    = false
  description = "STACKIT resource manager container ID (organization or folder) projects are created under."
}

variable "stackit_owner_email" {
  type        = string
  nullable    = false
  description = "Email address assigned as the owner of every STACKIT project this building block creates."
}

variable "stackit_service_account_email" {
  type        = string
  nullable    = false
  description = "Email of the STACKIT service account used for Workload Identity Federation (OIDC) authentication."
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
  description = "Supernet CIDR each environment's SNA carves new network ranges from. Must contain exactly the keys \"prod\", \"qa\" and \"test\"."

  validation {
    condition     = alltrue([for k in ["prod", "qa", "test"] : contains(keys(var.network_base_cidrs), k)])
    error_message = "network_base_cidrs must define an entry for each of \"prod\", \"qa\" and \"test\"."
  }
}
