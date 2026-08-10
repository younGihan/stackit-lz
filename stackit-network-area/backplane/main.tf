# Registers ../buildingblock (stackit-network-area/buildingblock) as an orderable building block.
# network_area_name is the only per-order input; the STACKIT organization and service account are
# fixed platform configuration.
resource "meshstack_building_block_definition" "stackit_network_area" {
  metadata = {
    owned_by_workspace = var.workspace_identifier
  }

  spec = {
    display_name = "STACKIT Network Area"
    description  = "Creates a new STACKIT Network Area (SNA). Its region (network ranges, transfer network) is configured separately before projects can be placed on it."
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
      network_area_name = {
        display_name    = "Network Area Name"
        description     = "Name of the STACKIT network area (SNA) to create."
        type            = "STRING"
        assignment_type = "USER_INPUT"
      }

      organization_id = {
        display_name    = "STACKIT Organization ID"
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.organization_id)
      }

      stackit_service_account_email = {
        display_name    = "STACKIT Service Account Email"
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.stackit_service_account_email)
      }
    }

    outputs = {
      network_area_id = {
        display_name    = "Network Area ID"
        type            = "STRING"
        assignment_type = "NONE"
      }

      network_area_url = {
        display_name    = "Open Network Area"
        type            = "STRING"
        assignment_type = "RESOURCE_URL"
      }
    }
  }
}
