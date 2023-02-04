resource "scaleway_domain_zone" "this" {
  domain     = var.domain
  project_id = var.project_id
  subdomain  = var.subdomain
}

resource "scaleway_tem_domain" "this" {
  count = var.setup_tem ? 1 : 0

  name       = local.dns_zone
  project_id = var.project_id
}

resource "scaleway_domain_record" "dkim" {
  count = var.setup_tem ? 1 : 0

  data     = scaleway_tem_domain.this[count.index].dkim_config
  dns_zone = local.dns_zone
  name     = format("%s._domainkey", scaleway_tem_domain.this[count.index].project_id)
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
