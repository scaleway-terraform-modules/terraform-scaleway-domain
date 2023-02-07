output "dns_zone" {
  description = "DNS Zone of the domain."
  value       = local.dns_zone
}

output "tem_id" {
  description = "ID of the Transaction Email Domain."
  value       = coalesce(scaleway_tem_domain.this[*].id, null)
}

output "tem_status" {
  description = "Status of the Transaction Email Domain."
  value       = coalesce(scaleway_tem_domain.this[*].status, null)
}
