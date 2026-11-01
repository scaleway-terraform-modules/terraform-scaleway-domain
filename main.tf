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
  region     = local.tem_region
}

resource "scaleway_domain_record" "bimi" {
  count = var.bimi == null ? 0 : 1

  data     = format("v=BIMI1;l=%s;a=%s;avp=%s", var.bimi.logo_url, var.bimi.vmc_url == null ? "" : var.bimi.vmc_url, var.bimi.avatar_preference)
  dns_zone = local.dns_zone
  name     = "default._bimi"
  ttl      = var.bimi.ttl
  type     = "TXT"
}

resource "scaleway_domain_record" "dkim" {
  count = var.setup_tem ? 1 : 0

  data     = scaleway_tem_domain.this[count.index].dkim_config
  dns_zone = local.dns_zone
  name     = trimsuffix(scaleway_tem_domain.this[count.index].dkim_name, format(".%s.", local.dns_zone))
  type     = "TXT"
}

resource "scaleway_domain_record" "dmarc" {
  count = var.setup_tem || var.dmarc != null ? 1 : 0

  data     = var.dmarc != null ? local.dmarc_record : (var.bimi != null && var.setup_tem ? replace(scaleway_tem_domain.this[count.index].dmarc_config, "p=none", "p=quarantine") : scaleway_tem_domain.this[count.index].dmarc_config)
  dns_zone = local.dns_zone
  name     = var.setup_tem ? trimsuffix(scaleway_tem_domain.this[count.index].dmarc_name, format(".%s.", local.dns_zone)) : "_dmarc"
  ttl      = var.dmarc == null ? null : var.dmarc.ttl
  type     = "TXT"
}

resource "scaleway_domain_record" "mx" {
  for_each = { for server in var.mx_servers.servers : server.address => server }

  data     = each.value.address
  dns_zone = local.dns_zone
  name     = ""
  priority = each.value.priority
  ttl      = var.mx_servers.ttl
  type     = "MX"
}

resource "scaleway_domain_record" "spf" {
  count = var.setup_tem ? 1 : 0

  data     = join(" ", concat(["v=spf1", scaleway_tem_domain.this[count.index].spf_config], try(var.spf.mechanisms, []), [try(var.spf.all, "-all")]))
  dns_zone = local.dns_zone
  name     = ""
  ttl      = var.spf == null ? null : var.spf.ttl
  type     = "TXT"
}

resource "scaleway_tem_domain_validation" "this" {
  count = var.setup_tem ? 1 : 0

  domain_id = scaleway_tem_domain.this[count.index].id
  region    = local.tem_region

  depends_on = [
    scaleway_domain_record.dkim,
    scaleway_domain_record.dmarc,
    scaleway_domain_record.mx,
    scaleway_domain_record.spf,
  ]
}
