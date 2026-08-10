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
  description = "Git URL of the repository containing the stackit-network-area building block implementation (this repo, once pushed to your git hosting)."
}

variable "bbd_repository_path" {
  type        = string
  default     = "stackit-network-area/buildingblock"
  nullable    = false
  description = "Path within bbd_repository_url to the stackit-network-area module."
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

variable "organization_id" {
  type        = string
  nullable    = false
  description = "STACKIT organization ID that new network areas are created under."
}

variable "stackit_service_account_email" {
  type        = string
  nullable    = false
  description = "Email of the STACKIT service account used for Workload Identity Federation (OIDC) authentication."
}
