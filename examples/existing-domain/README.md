# Existing domain

This example shows how to import an existing domain named `example.net` in order to manage it.

The zone is imported by the `import` block in `main.tf`, at the address `module.domain.scaleway_domain_zone.this`. The import ID is the zone name (`{subdomain}.{domain}`, or just `{domain}` for the root zone). Once the zone is in the state, the `import` block has no effect and can be removed.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example won't work as the domain name has been reserved by IANA for examples and documentations. See [rfc-2606, §3](https://www.rfc-editor.org/rfc/rfc2606.html#section-3) for more informations.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0 |
| <a name="requirement_scaleway"></a> [scaleway](#requirement_scaleway) | ~> 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider_scaleway) | 2.17.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_domain"></a> [domain](#module_domain) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [scaleway_account_project.default](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |
<!-- END_TF_DOCS -->
