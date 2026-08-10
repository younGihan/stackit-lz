data "meshstack_platforms" "stackit" {
  identifier = var.stackit_platform_identifier
}

data "meshstack_landingzones" "stackit" {
  count = var.stackit_landing_zone_name != null ? 1 : 0

  platform_uuid = local.stackit_platform.metadata.uuid
  identifier    = var.stackit_landing_zone_name
}
