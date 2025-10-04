resource "scaleway_domain_zone" "this" {
  domain     = var.domain
  project_id = var.project_id
  subdomain  = var.subdomain
}

resource "scaleway_tem_domain" "this" {
  count = var.setup_tem ? 1 : 0

  accept_tos = true
  name       = local.dns_zone
  project_id = var.project_id
}

resource "scaleway_domain_record" "bimi" {
  count = var.bimi_logo_url != null ? 1 : 0

  data     = format("v=BIMI1;l=%s", var.bimi_logo_url)
  dns_zone = local.dns_zone
  name     = "default._bimi"
  type     = "TXT"
}

resource "scaleway_domain_record" "dkim" {
  count = var.setup_tem ? 1 : 0

  data     = scaleway_tem_domain.this[count.index].dkim_config
  dns_zone = local.dns_zone
  name     = format("%s._domainkey", scaleway_tem_domain.this[count.index].project_id)
  type     = "TXT"
}

resource "scaleway_domain_record" "dmarc" {
  count = var.setup_tem ? 1 : 0

  data     = scaleway_tem_domain.this[count.index].dmarc_config
  dns_zone = local.dns_zone
  name     = trimsuffix(scaleway_tem_domain.this[count.index].dmarc_name, format(".%s.", local.dns_zone))
  type     = "TXT"
}

resource "scaleway_domain_record" "mx" {
  count = length(var.mx_servers)

  data     = var.mx_servers[count.index].address
  dns_zone = local.dns_zone
  name     = ""
  priority = var.mx_servers[count.index].priority
  type     = "MX"
}

resource "scaleway_domain_record" "spf" {
  count = var.setup_tem ? 1 : 0

  data     = format("v=spf1 %s -all", scaleway_tem_domain.this[count.index].spf_config)
  dns_zone = local.dns_zone
  name     = ""
  type     = "TXT"
}

resource "scaleway_tem_domain_validation" "this" {
  count = var.setup_tem ? 1 : 0

  domain_id = scaleway_tem_domain.this[count.index].id
}
