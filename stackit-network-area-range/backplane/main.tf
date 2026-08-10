# Registers ../buildingblock (stackit-network-area-range/buildingblock) as an orderable building
# block. All per-order fields identify which SNA to extend and with what range; the STACKIT
# organization/service-account/region are fixed platform configuration.
resource "meshstack_building_block_definition" "stackit_network_area_range" {
  metadata = {
    owned_by_workspace = var.workspace_identifier
  }

  spec = {
    display_name = "STACKIT Network Area Range"
    description  = "Adds a new network range to an existing STACKIT Network Area (SNA)."
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
      network_area_id = {
        display_name    = "Network Area ID"
        description     = "ID of the existing SNA to add a range to."
        type            = "STRING"
        assignment_type = "USER_INPUT"
      }

      network_base_cidr = {
        display_name    = "Network Base CIDR"
        description     = "Supernet the new range is carved from (e.g. \"10.10.0.0/16\"). Only used when network_range_override is not set."
        type            = "STRING"
        assignment_type = "USER_INPUT"
      }

      network_prefix_length = {
        display_name    = "Network Prefix Length"
        description     = "Prefix length of the range to add (e.g. 24 for a /24)."
        type            = "INTEGER"
        assignment_type = "USER_INPUT"
        default_value   = jsonencode(24)
      }

      network_range_override = {
        display_name    = "Network Range Override"
        description     = "Set to an existing CIDR to add/reuse it instead of computing the next free block from network_base_cidr."
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

      stackit_region = {
        display_name    = "STACKIT Region"
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.stackit_region)
      }
    }

    outputs = {
      network_range = {
        display_name    = "Network Range"
        type            = "STRING"
        assignment_type = "NONE"
      }

      network_range_was_computed = {
        display_name    = "Network Range Was Computed"
        type            = "BOOLEAN"
        assignment_type = "NONE"
      }
    }
  }
}
