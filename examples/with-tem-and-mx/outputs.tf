output "root_zone" {
  description = "DNS Zone of the root domain."
  value       = module.root.dns_zone
}

output "subdomain_zone" {
  description = "DNS Zone of the subdomain."
  value       = module.subdomain.dns_zone
}

output "tem_id" {
  description = "ID of the Transaction Email Domain."
  value       = module.subdomain.tem_id
}

output "tem_status" {
  description = "Status of the Transaction Email Domain."
  value       = module.subdomain.tem_status
}
