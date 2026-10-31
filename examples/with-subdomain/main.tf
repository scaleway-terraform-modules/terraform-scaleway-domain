provider "scaleway" {}

locals {
  domain_name = "example.net"
  subdomain   = "contact"
}

module "subdomain" {
  source = "../../"

  domain    = local.domain_name
  subdomain = local.subdomain
}
