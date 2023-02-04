output "root_zone" {
  description = "DNS Zone of the root domain."
  value       = module.root.dns_zone
}

output "subdomain_zone" {
  description = "DNS Zone of the subdomain."
  value       = module.subdomain.dns_zone
}
