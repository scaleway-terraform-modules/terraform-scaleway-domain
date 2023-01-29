locals {
  dns_zone = var.subdomain != "" ? format("%s.%s", scaleway_domain_zone.this.subdomain, scaleway_domain_zone.this.domain) : scaleway_domain_zone.this.domain
}
