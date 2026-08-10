data "meshstack_platforms" "stackit" {
  identifier = var.stackit_platform_identifier
}

# Landing zone per environment is hardcoded, not configurable - see locals.landing_zone_names.
data "meshstack_landingzones" "qa" {
  platform_uuid = local.stackit_platform.metadata.uuid
  identifier    = local.landing_zone_names.qa
}

data "meshstack_landingzones" "prod" {
  platform_uuid = local.stackit_platform.metadata.uuid
  identifier    = local.landing_zone_names.prod
}
