# Registers ../.. (buildingblock/stackit-project-creation) as an orderable building block. Only
# project_name varies per instance - everything else is static platform configuration baked into
# this version. See ../../starter-kit/backplane for an example consumer.
resource "meshstack_building_block_definition" "stackit_project_creation" {
  metadata = {
    owned_by_workspace = var.workspace_identifier
  }

  spec = {
    display_name = "STACKIT Project Creation"
    description  = "Creates a STACKIT project in the SNA matching the meshProject's environment tag, allocating it its own network range."
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
        description     = "meshStack workspace identifier, used to look up the meshProject's environment tag at runtime."
        type            = "STRING"
        assignment_type = "WORKSPACE_IDENTIFIER"
      }

      project_name = {
        display_name    = "Project Name"
        description     = "Name of the meshProject to create the STACKIT project for."
        type            = "STRING"
        assignment_type = "USER_INPUT"
      }

      sna_network_area_ids = {
        display_name    = "SNA Network Area IDs"
        description     = "STACKIT Network Area ID per environment (prod/qa/test)."
        type            = "CODE"
        assignment_type = "STATIC"
        argument        = jsonencode(jsonencode(var.sna_network_area_ids))
      }

      network_base_cidrs = {
        display_name    = "Network Base CIDRs"
        description     = "Supernet CIDR per environment (prod/qa/test) new ranges are carved from."
        type            = "CODE"
        assignment_type = "STATIC"
        argument        = jsonencode(jsonencode(var.network_base_cidrs))
      }

      stackit_organization_id = {
        display_name    = "STACKIT Organization ID"
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.stackit_organization_id)
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

      network_range = {
        display_name    = "Network Range"
        type            = "STRING"
        assignment_type = "NONE"
      }
    }
  }
}
