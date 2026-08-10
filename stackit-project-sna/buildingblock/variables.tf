# ── meshStack trigger context ────────────────────────────────────────────────

variable "workspace_identifier" {
  type        = string
  nullable    = false
  description = "meshStack workspace identifier, used to look up the meshProject's environment tag at runtime."
}

variable "project_name" {
  type        = string
  nullable    = false
  description = "Name of the meshProject this run is triggered for, derived from the target tenant's owning project. Also used as the STACKIT project name."
}

# ── Environment / SNA selection ──────────────────────────────────────────────

variable "environment_tag_name" {
  type        = string
  default     = "environment"
  nullable    = false
  description = "Name of the meshProject tag whose value ('prod' or 'dev') selects which SNA the project is placed in."
}

variable "sna_network_area_ids" {
  type        = map(string)
  nullable    = false
  description = "STACKIT Network Area (SNA) ID for each environment. Must contain exactly the keys \"prod\" and \"dev\"."

  validation {
    condition     = alltrue([for k in ["prod", "dev"] : contains(keys(var.sna_network_area_ids), k)])
    error_message = "sna_network_area_ids must define an entry for each of \"prod\" and \"dev\"."
  }
}

# ── STACKIT project ───────────────────────────────────────────────────────────

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
  description = "STACKIT region passed to the provider configuration."
}

variable "additional_project_labels" {
  type        = map(string)
  default     = {}
  nullable    = false
  description = "Extra labels merged onto the STACKIT project, in addition to the networkArea label this template sets automatically."
}
