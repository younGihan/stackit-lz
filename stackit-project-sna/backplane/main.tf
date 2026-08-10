# Registers ../buildingblock (stackit-project-sna/buildingblock) as an orderable building block,
# targetable at a STACKIT tenant. project_name is derived from the target tenant's owning project -
# everything else is static platform configuration baked into this version.
resource "meshstack_building_block_definition" "stackit_project_sna" {
  metadata = {
    owned_by_workspace = var.workspace_identifier
  }

  spec = {
    display_name        = "STACKIT Project on SNA"
    description         = "Creates a STACKIT project in the SNA matching the meshProject's environment tag."
    target_type         = "TENANT_LEVEL"
    supported_platforms = [{ name = "STACKIT" }]
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
        description     = "meshStack workspace identifier, used to look up the meshProject's environment tag at runtime."
        type            = "STRING"
        assignment_type = "WORKSPACE_IDENTIFIER"
      }

      project_name = {
        display_name    = "Project Name"
        description     = "Name of the meshProject to create the STACKIT project for, derived from the target tenant's owning project."
        type            = "STRING"
        assignment_type = "PROJECT_IDENTIFIER"
      }

      sna_network_area_ids = {
        display_name    = "SNA Network Area IDs"
        description     = "STACKIT Network Area ID per environment (prod/dev)."
        type            = "CODE"
        assignment_type = "STATIC"
        argument        = jsonencode(jsonencode(var.sna_network_area_ids))
      }

      stackit_parent_container_id = {
        display_name    = "STACKIT Parent Container ID"
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.stackit_parent_container_id)
      }

      stackit_owner_email = {
        display_name    = "STACKIT Owner Email"
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.stackit_owner_email)
      }

      stackit_service_account_email = {
        display_name    = "STACKIT Service Account Email"
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.stackit_service_account_email)
      }
    }

    outputs = {
      stackit_project_id = {
        display_name    = "STACKIT Project ID"
        type            = "STRING"
        assignment_type = "PLATFORM_TENANT_ID"
      }

      stackit_project_name = {
        display_name    = "STACKIT Project Name"
        type            = "STRING"
        assignment_type = "NONE"
      }

      project_url = {
        display_name    = "Open Project"
        type            = "STRING"
        assignment_type = "RESOURCE_URL"
      }
    }

    # PROJECT_LIST: needed by the data.meshstack_project lookup that reads the environment tag.
    permissions = ["PROJECT_LIST"]
  }
}
