locals {
  # Transactional Email is only available in fr-par: other regions return an error.
  tem_region = "fr-par"

  # DMARC record built from 'var.dmarc', when set.
  dmarc_record = var.dmarc == null ? null : join("; ", concat(
    ["v=DMARC1", format("p=%s", var.dmarc.policy)],
    var.dmarc.subdomain_policy == null ? [] : [format("sp=%s", var.dmarc.subdomain_policy)],
    var.dmarc.pct == null ? [] : [format("pct=%d", var.dmarc.pct)],
    length(var.dmarc.rua) == 0 ? [] : [format("rua=%s", join(",", [for address in var.dmarc.rua : "mailto:${address}"]))],
    length(var.dmarc.ruf) == 0 ? [] : [format("ruf=%s", join(",", [for address in var.dmarc.ruf : "mailto:${address}"]))],
  ))

  dns_zone = var.subdomain != "" ? format("%s.%s", scaleway_domain_zone.this.subdomain, scaleway_domain_zone.this.domain) : scaleway_domain_zone.this.domain
}
