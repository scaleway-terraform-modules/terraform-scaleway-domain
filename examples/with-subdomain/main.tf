module "root_example_net" {
  source = "../../"

  domain = "example.net"
}

module "contact_example_net" {
  source = "../../"

  domain    = "example.net"
  subdomain = "contact"
}
