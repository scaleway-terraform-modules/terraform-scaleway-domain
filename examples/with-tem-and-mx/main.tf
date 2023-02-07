module "root_example_net" {
  source = "../../"

  domain = "example.net"
}

module "contact_example_net" {
  source = "../../"

  domain    = "example.net"
  subdomain = "contact"
  setup_tem = true

  mx_servers = [{
    address  = "mx1.example.com."
    priority = 10
    }, {
    address  = "mx2.example.com."
    priority = 20
  }]
}
