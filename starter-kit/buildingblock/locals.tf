locals {
  stackit_platform = one(data.meshstack_platforms.stackit.platforms)

  stackit_landing_zone = (
    var.stackit_landing_zone_name != null
    ? one(data.meshstack_landingzones.stackit[0].landing_zones)
    : null
  )
}
