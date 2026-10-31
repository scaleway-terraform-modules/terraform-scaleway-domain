output "subdomain_zone" {
  description = "DNS Zone of the subdomain."
  value       = module.subdomain.dns_zone
}

output "tem_id" {
  description = "ID of the Transactional Email Domain."
  value       = module.subdomain.tem_id
}

output "tem_status" {
  description = "Status of the Transactional Email Domain."
  value       = module.subdomain.tem_status
}
