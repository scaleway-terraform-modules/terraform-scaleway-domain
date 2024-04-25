output "dns_zone" {
  description = "DNS Zone of the domain."
  value       = local.dns_zone
}

output "tem_id" {
  description = "ID of the Transaction Email Domain."
  value       = coalesce(scaleway_tem_domain.this[*].id, null)
}

output "tem_reputation" {
  description = "Reputation of the Transaction Email Domain."
  value       = try(scaleway_tem_domain.this[0].reputation, null)
}

output "tem_validated" {
  description = "Indicates if the domain has been verified for email sending."
  value       = try(scaleway_tem_domain_validation.this[0].validated, null)
}
