# Registers ../buildingblock (starter-kit/buildingblock) as an orderable building block: creates a
# qa and a prod meshProject and orders a STACKIT Project Creation instance for each. The STACKIT Project
# Creation version to order against is baked in as a STATIC input, since starter-kit's own
# Terraform run has no other way to discover it (separate state, separate backplane).
resource "meshstack_building_block_definition" "starter_kit" {
  metadata = {
    owned_by_workspace = var.workspace_identifier
  }

  spec = {
    display_name = "STACKIT QA+Prod Bootstrap"
    description  = "Creates a qa and a prod meshProject and orders a STACKIT Project Creation instance for each."
    target_type  = "WORKSPACE_LEVEL"
  }

  version_spec = {
    draft         = var.bbd_draft
    deletion_mode = "DELETE"

    implementation = {
      terraform = {
        terraform_version              = "1.5.0"
        repository_url                 = var.bbd_repository_url
        repository_path                = var.bbd_repository_path
        ref_name                       = var.bbd_ref_name
        async                          = false
        use_mesh_http_backend_fallback = true
      }
    }

    inputs = {
      workspace_identifier = {
        display_name    = "Workspace Identifier"
        description     = "meshStack workspace identifier: owns the qa/prod meshProjects and is the target for both STACKIT Project Creation instances."
        type            = "STRING"
        assignment_type = "WORKSPACE_IDENTIFIER"
      }

      stackit_project_creation_bb_version_uuid = {
        display_name    = "STACKIT Project Creation Version UUID"
        description     = "UUID of the STACKIT Project Creation building block version to order qa/prod instances against."
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.stackit_project_creation_bb_version_uuid)
      }

      stackit_platform_identifier = {
        display_name    = "STACKIT Platform Identifier"
        description     = "Full identifier (<platform-name>.<location-name>) of the already-existing STACKIT platform to create the qa/prod tenants on."
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.stackit_platform_identifier)
      }

      stackit_landing_zone_name = {
        display_name    = "STACKIT Landing Zone Name"
        description     = "Name of the landing zone (on stackit_platform_identifier) to assign the qa/prod tenants to. Leave unset to create tenants without a landing zone."
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.stackit_landing_zone_name)
      }
    }

    outputs = {
      qa_building_block_status = {
        display_name    = "QA Building Block Status"
        type            = "STRING"
        assignment_type = "NONE"
      }

      prod_building_block_status = {
        display_name    = "Prod Building Block Status"
        type            = "STRING"
        assignment_type = "NONE"
      }
    }

    # PROJECT_SAVE: needed to create the qa/prod meshProjects. PLATFORMINSTANCE_LIST/LANDINGZONE_LIST:
    # needed to look up the target STACKIT platform/landing zone. TENANT_SAVE: needed to create the
    # qa/prod tenants. BUILDINGBLOCK_SAVE: needed to order the STACKIT Project Creation instances
    # against them. This is the set of workspace permissions granted via the ephemeral API key
    # meshStack issues to each run of this building block.
    permissions = ["PROJECT_SAVE", "PLATFORMINSTANCE_LIST", "LANDINGZONE_LIST", "TENANT_SAVE", "BUILDINGBLOCK_SAVE"]
  }
}
