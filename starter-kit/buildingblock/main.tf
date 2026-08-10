resource "meshstack_project" "qa" {
  metadata = {
    name               = "qa"
    owned_by_workspace = var.workspace_identifier
  }

  spec = {
    display_name = "QA"
    tags = {
      environment          = ["qa"]
      projectOwner         = ["Anna Admin"]
      LandingZoneClearance = ["cloud-native"]
      Schutzbedarf         = ["public"]
    }
  }
}

resource "meshstack_project" "prod" {
  metadata = {
    name               = "prod"
    owned_by_workspace = var.workspace_identifier
  }

  spec = {
    display_name = "Prod"
    tags = {
      environment          = ["prod"]
      projectOwner         = ["Anna Admin"]
      LandingZoneClearance = ["cloud-native"]
      Schutzbedarf         = ["public"]
    }
  }
}

# STACKIT Project Creation is TENANT_LEVEL, so each project needs its own tenant to attach the
# building block to. platform_ref comes from the already-existing STACKIT platform looked up in
# data.tf; landing_zone_ref is hardcoded per environment - see locals.landing_zone_names.
resource "meshstack_tenant" "qa" {
  metadata = {
    owned_by_workspace = var.workspace_identifier
    owned_by_project   = meshstack_project.qa.metadata.name
  }

  spec = {
    platform_ref     = local.stackit_platform.ref
    landing_zone_ref = local.qa_landing_zone.ref
  }
  wait_for_completion = false

}

resource "meshstack_tenant" "prod" {
  metadata = {
    owned_by_workspace = var.workspace_identifier
    owned_by_project   = meshstack_project.prod.metadata.name
  }

  spec = {
    platform_ref     = local.stackit_platform.ref
    landing_zone_ref = local.prod_landing_zone.ref
  }
  wait_for_completion = false

}

# project_name and workspace_identifier are PROJECT_IDENTIFIER / WORKSPACE_IDENTIFIER inputs on the
# STACKIT Project Creation BBD - meshStack derives both from target_ref automatically, so they're
# not set here.
resource "meshstack_building_block" "qa" {
  spec = {
    building_block_definition_version_ref = { uuid = var.stackit_project_creation_bb_version_uuid }
    display_name                          = "STACKIT Project - qa"
    target_ref                            = meshstack_tenant.qa.ref
    inputs                                = {}
  }
}

resource "meshstack_building_block" "prod" {
  spec = {
    building_block_definition_version_ref = { uuid = var.stackit_project_creation_bb_version_uuid }
    display_name                          = "STACKIT Project - prod"
    target_ref                            = meshstack_tenant.prod.ref
    inputs                                = {}
  }
}
