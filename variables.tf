variable "domain" {
  description = "Name of the domain to manage."
  type        = string
}

variable "bimi_avatar_preference" {
  type        = string
  description = "Avatar Preference. Lets the Domain Owner express a preference to show either the BIMI logo or a sender’s personal avatar where both are supported."
  default     = "brand"
}

variable "bimi_logo_url" {
  type        = string
  description = "URL of the logo that should be used for BIMI. The file must be a SVG document and follow [BIMI specifications](https://bimigroup.org/creating-bimi-svg-logo-files/). Logos are only displayed when DMARC is enforced: see the README for the requirements."
  default     = ""
}

variable "bimi_vmc_url" {
  type        = string
  description = "URL of the Verified Mark Certificate or Common Mark Certificate."
  default     = ""
}

variable "mx_servers" {
  description = "MX servers of the domain. **MX servers are required to enable Transactional Email.** The default points to Scaleway's blackhole server, which rejects all incoming mail, and is created even when `setup_tem` is `false`. Set your own servers, or `[]` to manage MX records outside of this module."
  type = list(object({
    address  = string
    priority = number
  }))
  default = [{
    address  = "blackhole.scw-tem.cloud."
    priority = 10
  }]
}

variable "project_id" {
  description = "ID of the project the domain is associated with. Resource will be created in the project set at the provider level if null."
  type        = string
  default     = null
}

variable "subdomain" {
  description = "Name of the subdomain to manage."
  type        = string
  default     = ""
}

variable "setup_tem" {
  type        = bool
  description = "Whether to set up Transactional Email for the domain. **Beware that the service is only available in region `fr-par` at the moment.**"
  default     = false
}

variable "spf" {
  description = "Settings of the SPF record published with Transactional Email. `mechanisms` lists additional SPF mechanisms authorising other services to send mail for the domain, e.g. `include:_spf.google.com` or `ip4:192.0.2.1`, inserted before the final `all`. `all` sets how receivers treat other senders: `-all` (fail, the default), `~all` (softfail) or `?all` (neutral). Requires `setup_tem`."
  type = object({
    mechanisms = optional(list(string), [])
    all        = optional(string, "-all")
  })
  default = null

  validation {
    condition     = alltrue([for mechanism in try(var.spf.mechanisms, []) : can(regex("^[-+?~]?((a|mx)([:/][^[:space:]]+)?|ptr(:[^[:space:]]+)?|(include|exists|ip4|ip6):[^[:space:]]+)$", mechanism))])
    error_message = "'spf.mechanisms' values must be single SPF mechanisms (`a`, `mx`, `ptr`, `include:`, `exists:`, `ip4:` or `ip6:`, with an optional qualifier), without spaces. Use 'spf.all' to set the final `all`."
  }

  validation {
    condition     = contains(["-all", "~all", "?all"], try(var.spf.all, "-all"))
    error_message = "'spf.all' must be one of `-all`, `~all` or `?all`."
  }

  validation {
    condition     = var.spf == null || var.setup_tem
    error_message = "'spf' requires 'setup_tem' to be true: the module only publishes an SPF record with Transactional Email."
  }
}
