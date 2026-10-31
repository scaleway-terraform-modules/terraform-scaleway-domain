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
  count = var.bimi_logo_url != "" ? 1 : 0

  data     = format("v=BIMI1;l=%s;a=%s;avp=%s", var.bimi_logo_url, var.bimi_vmc_url, var.bimi_avatar_preference)
  dns_zone = local.dns_zone
  name     = "default._bimi"
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
  count = var.setup_tem ? 1 : 0

  data     = var.bimi_logo_url != "" && var.setup_tem ? replace(scaleway_tem_domain.this[count.index].dmarc_config, "p=none", "p=quarantine") : scaleway_tem_domain.this[count.index].dmarc_config
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

  data     = join(" ", concat(["v=spf1", scaleway_tem_domain.this[count.index].spf_config], try(var.spf.mechanisms, []), [try(var.spf.all, "-all")]))
  dns_zone = local.dns_zone
  name     = ""
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
