provider "scaleway" {
}

data "scaleway_account_project" "default" {
  name = "default"
}

locals {
  domain_name = "example.net"
  subdomain   = "contact"
}

module "subdomain" {
  source = "../../"

  domain     = local.domain_name
  project_id = data.scaleway_account_project.default.id
  subdomain  = local.subdomain

  setup_tem = true
  mx_servers = [{
    address  = "mx1.example.com."
    priority = 10
    }, {
    address  = "mx2.example.com."
    priority = 20
  }]
}
