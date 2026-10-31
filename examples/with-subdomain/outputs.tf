output "subdomain_zone" {
  description = "DNS Zone of the subdomain."
  value       = module.subdomain.dns_zone
}
