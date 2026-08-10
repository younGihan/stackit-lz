terraform {
  required_version = ">= 1.5.0"

  required_providers {
    meshstack = {
      source  = "meshcloud/meshstack"
      version = ">= 0.24.0"
    }
    stackit = {
      source  = "stackitcloud/stackit"
      version = ">= 0.98.0"
    }
  }
}
