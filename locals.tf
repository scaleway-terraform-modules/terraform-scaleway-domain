locals {
  # Transactional Email is only available in fr-par: other regions return an error.
  tem_region = "fr-par"

  dns_zone = var.subdomain != "" ? format("%s.%s", scaleway_domain_zone.this.subdomain, scaleway_domain_zone.this.domain) : scaleway_domain_zone.this.domain
}
