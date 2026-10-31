# Subdomain with Transactional Email and external MX servers

This example shows how to manage the sub-domain `contact.example.net`, setting up transaction email and external MX records.

## Usage

Configure the [scaleway provider](https://www.terraform.io/docs/providers/scaleway/index.html) with your own credentials, then:

```sh
terraform init
terraform plan
terraform apply
```

Note that this example won't work as the domain name has been reserved by IANA for examples and documentations. See [rfc-2606, §3](https://www.rfc-editor.org/rfc/rfc2606.html#section-3) for more informations.
