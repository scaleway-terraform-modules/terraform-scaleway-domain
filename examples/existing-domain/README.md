# Existing domain

This example shows how to import an existing domain named `example.net` in order to manage it.

The zone is imported by the `import` block in `main.tf`, at the address `module.domain.scaleway_domain_zone.this`. The import ID is the zone name (`{subdomain}.{domain}`, or just `{domain}` for the root zone). Once the zone is in the state, the `import` block has no effect and can be removed.

## Usage

Configure the [scaleway provider](https://www.terraform.io/docs/providers/scaleway/index.html) with your own credentials, then:

```sh
terraform init
terraform plan
terraform apply
```

Note that this example won't work as the domain name has been reserved by IANA for examples and documentations. See [rfc-2606, §3](https://www.rfc-editor.org/rfc/rfc2606.html#section-3) for more informations.
