provider "scaleway" {}

locals {
  domain_name = "example.net"
}

import {
  to = module.domain.scaleway_domain_zone.this
  id = local.domain_name
}

module "domain" {
  source = "../../"

  domain = local.domain_name
}
