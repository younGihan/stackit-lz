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

resource "meshstack_building_block" "qa" {
  spec = {
    building_block_definition_version_ref = { uuid = var.stackit_project_creation_bb_version_uuid }
    display_name                          = "STACKIT Project - qa"

    target_ref = {
      kind = "meshWorkspace"
      name = var.workspace_identifier
    }

    inputs = {
      project_name = {
        value = jsonencode(meshstack_project.qa.metadata.name)
      }
    }
  }
}

resource "meshstack_building_block" "prod" {
  spec = {
    building_block_definition_version_ref = { uuid = var.stackit_project_creation_bb_version_uuid }
    display_name                          = "STACKIT Project - prod"

    target_ref = {
      kind = "meshWorkspace"
      name = var.workspace_identifier
    }

    inputs = {
      project_name = {
        value = jsonencode(meshstack_project.prod.metadata.name)
      }
    }
  }
}
