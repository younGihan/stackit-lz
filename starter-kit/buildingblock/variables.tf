variable "workspace_identifier" {
  type        = string
  nullable    = false
  description = "meshStack workspace that owns the two demo meshProjects and their tenants."
}

variable "stackit_project_creation_bb_version_uuid" {
  type        = string
  nullable    = false
  description = "UUID of the STACKIT Project Creation building block version to order qa/prod instances against (see ../../stackit-project-creation/backplane)."
}

variable "stackit_platform_identifier" {
  type        = string
  nullable    = false
  description = "Full identifier (<platform-name>.<location-name>) of the already-existing STACKIT platform to create the qa/prod tenants on. The landing zone per environment is hardcoded (see locals.landing_zone_names)."
}
