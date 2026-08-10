# Registers ../buildingblock (stackit-network/buildingblock) as an orderable building block,
# targetable at a STACKIT tenant. project_id is derived from the target tenant.
resource "meshstack_building_block_definition" "stackit_network" {
  metadata = {
    owned_by_workspace = var.workspace_identifier
  }

  spec = {
    display_name        = "STACKIT Network"
    description         = "Creates a network inside a STACKIT project, auto-allocated from the project's SNA."
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
      project_id = {
        display_name    = "STACKIT Project ID"
        description     = "STACKIT project ID of the target tenant."
        type            = "STRING"
        assignment_type = "PLATFORM_TENANT_ID"
      }

      network_name = {
        display_name    = "Network Name"
        description     = "Name of the STACKIT network to create."
        type            = "STRING"
        assignment_type = "USER_INPUT"
      }

      network_prefix_length = {
        display_name    = "Network Prefix Length"
        description     = "IPv4 prefix length for the network (24-29)."
        type            = "INTEGER"
        assignment_type = "USER_INPUT"
        default_value   = jsonencode(24)
      }

      routed = {
        display_name    = "Routed"
        description     = "If true, the network is accessible from other networks in the same SNA."
        type            = "BOOLEAN"
        assignment_type = "USER_INPUT"
        default_value   = jsonencode(true)
      }

      ipv4_nameservers = {
        display_name    = "IPv4 Nameservers"
        description     = "IPv4 nameservers for the network. Leave empty to fall back to the project's SNA default nameservers."
        type            = "CODE"
        assignment_type = "USER_INPUT"
      }

      stackit_service_account_email = {
        display_name    = "STACKIT Service Account Email"
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.stackit_service_account_email)
      }
    }

    outputs = {
      network_id = {
        display_name    = "Network ID"
        type            = "STRING"
        assignment_type = "NONE"
      }

      network_cidr = {
        display_name    = "Network CIDR"
        type            = "CODE"
        assignment_type = "NONE"
      }
    }
  }
}
