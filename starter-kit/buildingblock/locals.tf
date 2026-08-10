locals {
  stackit_platform = one(data.meshstack_platforms.stackit.platforms)

  landing_zone_names = {
    qa   = "qa"
    prod = "prod"
  }

  qa_landing_zone   = one(data.meshstack_landingzones.qa.landing_zones)
  prod_landing_zone = one(data.meshstack_landingzones.prod.landing_zones)
}
