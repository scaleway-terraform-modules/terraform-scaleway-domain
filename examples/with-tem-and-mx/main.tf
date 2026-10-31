provider "scaleway" {}

locals {
  domain_name = "example.net"
  subdomain   = "contact"
}

module "subdomain" {
  source = "../../"

  domain    = local.domain_name
  subdomain = local.subdomain

  setup_tem = true
  mx_servers = [{
    address  = "mx1.example.com."
    priority = 10
    }, {
    address  = "mx2.example.com."
    priority = 20
  }]
}
