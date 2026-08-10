variable "workspace_identifier" {
  type        = string
  nullable    = false
  description = "meshStack workspace that owns the two demo meshProjects and is the target both STACKIT Project Creation instances run against."
}

variable "stackit_project_creation_bb_version_uuid" {
  type        = string
  nullable    = false
  description = "UUID of the STACKIT Project Creation building block version to order qa/prod instances against (see ../stackit-project-creation/backplane)."
}
