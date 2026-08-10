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
  description = "Git URL of the repository containing the starter-kit building block implementation (this repo, once pushed to your git hosting)."
}

variable "bbd_repository_path" {
  type        = string
  default     = "starter-kit/buildingblock"
  nullable    = false
  description = "Path within bbd_repository_url to the starter-kit module."
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

# ── Dependency ────────────────────────────────────────────────────────────────

variable "stackit_project_creation_bb_version_uuid" {
  type        = string
  nullable    = false
  description = "UUID of the STACKIT Project Creation building block version to order qa/prod instances against. Output by ../../stackit-project-creation/backplane as building_block_definition_version_uuid."
}

variable "stackit_platform_identifier" {
  type        = string
  nullable    = false
  description = "Full identifier (<platform-name>.<location-name>) of the already-existing STACKIT platform to create the qa/prod tenants on."
}

variable "stackit_landing_zone_name" {
  type        = string
  default     = null
  description = "Name of the landing zone (on stackit_platform_identifier) to assign the qa/prod tenants to. Optional - leave null to create tenants without a landing zone."
}
