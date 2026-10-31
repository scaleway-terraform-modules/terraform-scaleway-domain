output "dns_zone" {
  description = "DNS Zone of the domain."
  value       = local.dns_zone
}

output "dns_zone_ns" {
  description = "Name servers of the DNS zone, to declare at the registrar, or as NS records in the parent zone for a subdomain."
  value       = scaleway_domain_zone.this.ns
}

output "dns_zone_ns_default" {
  description = "Default Scaleway name servers of the DNS zone."
  value       = scaleway_domain_zone.this.ns_default
}

output "dns_zone_ns_master" {
  description = "Master name servers of the DNS zone, for secondary DNS setups."
  value       = scaleway_domain_zone.this.ns_master
}

output "dns_zone_status" {
  description = "Status of the DNS zone."
  value       = scaleway_domain_zone.this.status
}

output "tem_id" {
  description = "ID of the Transactional Email Domain."
  value       = try(scaleway_tem_domain.this[0].id, null)
}

output "tem_reputation" {
  description = "Reputation of the Transactional Email Domain."
  value       = try(scaleway_tem_domain.this[0].reputation, null)
}

output "tem_smtp" {
  description = "SMTP settings to send mail through Transactional Email: `host`, `port`, `port_alternative`, `port_unsecure`, `smtps_port`, `smtps_port_alternative` and `auth_user`. The password is a Scaleway API secret key, not managed by this module."
  value = try({
    host                   = scaleway_tem_domain.this[0].smtp_host
    port                   = scaleway_tem_domain.this[0].smtp_port
    port_alternative       = scaleway_tem_domain.this[0].smtp_port_alternative
    port_unsecure          = scaleway_tem_domain.this[0].smtp_port_unsecure
    smtps_port             = scaleway_tem_domain.this[0].smtps_port
    smtps_port_alternative = scaleway_tem_domain.this[0].smtps_port_alternative
    auth_user              = scaleway_tem_domain.this[0].smtps_auth_user
  }, null)
}

output "tem_status" {
  description = "Status of the Transactional Email Domain."
  value       = try(scaleway_tem_domain.this[0].status, null)
}

output "tem_validated" {
  description = "Indicates if the domain has been verified for email sending."
  value       = try(scaleway_tem_domain_validation.this[0].validated, null)
}
