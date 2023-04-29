provider "scaleway" {
}

data "scaleway_account_project" "default" {
  name = "default"
}

locals {
  domain_name = "example.net"
  subdomain   = "contact"
}

module "root" {
  source = "../../"

  domain     = local.domain_name
  project_id = data.scaleway_account_project.default.id
}

module "subdomain" {
  source = "../../"

  domain     = local.domain_name
  project_id = data.scaleway_account_project.default.id
  subdomain  = local.subdomain
}
