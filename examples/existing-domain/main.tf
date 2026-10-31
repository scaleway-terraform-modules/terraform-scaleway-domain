provider "scaleway" {
}

data "scaleway_account_project" "default" {
  name = "default"
}

locals {
  domain_name = "example.net"
}

import {
  to = module.domain.scaleway_domain_zone.this
  id = local.domain_name
}

module "domain" {
  source = "../../"

  domain     = local.domain_name
  project_id = data.scaleway_account_project.default.id
}
