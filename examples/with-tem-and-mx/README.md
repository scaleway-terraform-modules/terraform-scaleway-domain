# Complete domain

This example shows how to manage the domain `exemple.net` along with a subdomain named `contact`, setting up transaction email and external MX records on this latest.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example won't work as the domain name has been reserved by IANA for examples and documentations. See [rfc-2606, §3](https://www.rfc-editor.org/rfc/rfc2606.html#section-3) for more informations.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

