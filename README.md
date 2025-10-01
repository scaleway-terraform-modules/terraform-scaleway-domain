# Terraform / Scaleway

## Purpose

This repository is used to manage a domain on scaleway using terraform.
Beware this module *can not* be used to register a new domain. Existing domains must first be imported manually after initializing the terraform project. Refer to examples for more informations.

## Usage

- Setup the [scaleway provider](https://www.terraform.io/docs/providers/scaleway/index.html) in your tf file.
- Include this module in your tf file. Refer to [documentation](https://www.terraform.io/docs/modules/sources.html#generic-git-repository).

```hcl
module "my_domain" {
  source  = "scaleway-terraform-modules/domain/scaleway"
  version = "1.0.2"

}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13 |
| <a name="requirement_scaleway"></a> [scaleway](#requirement_scaleway) | >= 2.40.0 |

## Resources

| Name | Type |
|------|------|
| [scaleway_domain_record.bimi](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/domain_record) | resource |
| [scaleway_domain_record.dkim](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/domain_record) | resource |
| [scaleway_domain_record.dmarc](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/domain_record) | resource |
| [scaleway_domain_record.mx](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/domain_record) | resource |
| [scaleway_domain_record.spf](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/domain_record) | resource |
| [scaleway_domain_zone.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/domain_zone) | resource |
| [scaleway_tem_domain.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/tem_domain) | resource |
| [scaleway_tem_domain_validation.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/tem_domain_validation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input_domain) | Name of the domain to manage. | `string` | n/a | yes |
| <a name="input_bimi_avatar_preference"></a> [bimi_avatar_preference](#input_bimi_avatar_preference) | Avatar Preference. Lets the Domain Owner express a preference to show either the BIMI logo or a sender’s personal avatar where both are supported. | `string` | `"brand"` | no |
| <a name="input_bimi_logo_url"></a> [bimi_logo_url](#input_bimi_logo_url) | URL of the log that should be used for BIMI. The file must be a SVG document and follow [BIMI specifications](https://bimigroup.org/creating-bimi-svg-logo-files/). | `string` | `""` | no |
| <a name="input_bimi_vmc_url"></a> [bimi_vmc_url](#input_bimi_vmc_url) | URL of the Verified Mark Certificate or Common Mark Certificate. | `string` | `""` | no |
| <a name="input_mx_servers"></a> [mx_servers](#input_mx_servers) | Informations regarding MX servers. **MX servers are required to enable Transactional Emails.** | ```list(object({ address = string priority = number }))``` | ```[ { "address": "blackhole.scw-tem.cloud.", "priority": 10 } ]``` | no |
| <a name="input_project_id"></a> [project_id](#input_project_id) | ID of the project the domain is associated with. Ressource will be created in the project set at the provider level if null. | `string` | `null` | no |
| <a name="input_setup_tem"></a> [setup_tem](#input_setup_tem) | Whether to create a Transaction Email service. **Beware that the service is only available in region `fr-par` at the moment.** | `bool` | `false` | no |
| <a name="input_subdomain"></a> [subdomain](#input_subdomain) | Name of the subdomain to manage. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_zone"></a> [dns_zone](#output_dns_zone) | DNS Zone of the domain. |
| <a name="output_tem_id"></a> [tem_id](#output_tem_id) | ID of the Transaction Email Domain. |
| <a name="output_tem_reputation"></a> [tem_reputation](#output_tem_reputation) | Reputation of the Transaction Email Domain. |
| <a name="output_tem_status"></a> [tem_status](#output_tem_status) | Status of the Transaction Email Domain. |
| <a name="output_tem_validated"></a> [tem_validated](#output_tem_validated) | Indicates if the domain has been verified for email sending. |
<!-- END_TF_DOCS -->

## Authors

Module is maintained with help from [the community](https://github.com/scaleway-terraform-modules/terraform-scaleway-domain/graphs/contributors).

## License

Mozilla Public License 2.0 Licensed. See [LICENSE](https://github.com/scaleway-terraform-modules/terraform-scaleway-domain/tree/master/LICENSE) for full details.
