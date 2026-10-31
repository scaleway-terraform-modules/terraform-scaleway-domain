# Manage a subdomain

This example shows how to manage the domain `contact.example.net`.

## Usage

Configure the [scaleway provider](https://www.terraform.io/docs/providers/scaleway/index.html) with your own credentials, then:

```sh
terraform init
terraform plan
terraform apply
```

Note that this example won't work as the domain name has been reserved by IANA for examples and documentation. See [rfc-2606, §3](https://www.rfc-editor.org/rfc/rfc2606.html#section-3) for more information.
