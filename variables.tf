variable "domain" {
  type        = string
  description = "Name of the domain to manage."
}

variable "bimi_avatar_preference" {
  type        = string
  description = "Avatar Preference. Lets the Domain Owner express a preference to show either the BIMI logo or a sender’s personal avatar where both are supported."
  default     = "brand"

  validation {
    condition     = contains(["brand", "personal"], var.bimi_avatar_preference)
    error_message = "'bimi_avatar_preference' must be one of `brand` or `personal`."
  }
}

variable "bimi_logo_url" {
  type        = string
  description = "URL of the logo that should be used for BIMI. The file must be a SVG document and follow [BIMI specifications](https://bimigroup.org/creating-bimi-svg-logo-files/). Logos are only displayed when DMARC is enforced: see the README for the requirements."
  default     = ""

  validation {
    condition     = var.bimi_logo_url == "" || startswith(var.bimi_logo_url, "https://")
    error_message = "'bimi_logo_url' must be an `https://` URL."
  }
}

variable "bimi_vmc_url" {
  type        = string
  description = "URL of the Verified Mark Certificate or Common Mark Certificate."
  default     = ""

  validation {
    condition     = var.bimi_vmc_url == "" || startswith(var.bimi_vmc_url, "https://")
    error_message = "'bimi_vmc_url' must be an `https://` URL."
  }

  validation {
    condition     = var.bimi_vmc_url == "" || var.bimi_logo_url != ""
    error_message = "'bimi_vmc_url' requires 'bimi_logo_url' to be set."
  }
}

variable "mx_servers" {
  type = list(object({
    address  = string
    priority = number
  }))
  description = "MX servers of the domain. **MX servers are required to enable Transactional Email.** The default points to Scaleway's blackhole server, which rejects all incoming mail, and is created even when `setup_tem` is `false`. Set your own servers, or `[]` to manage MX records outside of this module. End external host names with a dot (e.g. `mx.example.com.`), as names without it may be relative to the zone."
  default = [{
    address  = "blackhole.scw-tem.cloud."
    priority = 10
  }]

  validation {
    condition     = alltrue([for server in var.mx_servers : server.priority >= 0 && server.priority <= 65535 && floor(server.priority) == server.priority])
    error_message = "'mx_servers[].priority' must be an integer between 0 and 65535."
  }

  validation {
    condition     = alltrue([for server in var.mx_servers : can(regex("^(?i)([a-z0-9]([a-z0-9-]*[a-z0-9])?\\.)*[a-z0-9]([a-z0-9-]*[a-z0-9])?\\.?$", server.address))])
    error_message = "'mx_servers[].address' must be a valid host name, e.g. `mx.example.net.`."
  }
}

variable "project_id" {
  type        = string
  description = "ID of the project the domain is associated with. Resource will be created in the project set at the provider level if null."
  default     = null
}

variable "subdomain" {
  type        = string
  description = "Name of the subdomain to manage."
  default     = ""

  validation {
    condition     = var.subdomain == "" || can(regex("^(?i)([a-z0-9_]([a-z0-9_-]*[a-z0-9])?\\.)*[a-z0-9_]([a-z0-9_-]*[a-z0-9])?$", var.subdomain))
    error_message = "'subdomain' must be a valid DNS name relative to 'domain', without a trailing dot, e.g. `contact`."
  }

  validation {
    condition     = !endswith(lower(var.subdomain), lower(".${var.domain}"))
    error_message = "'subdomain' must not include the parent domain: use e.g. `contact`, not `contact.example.net`."
  }
}

variable "setup_tem" {
  type        = bool
  description = "Whether to set up Transactional Email for the domain. Transactional Email is only available in region `fr-par`: the module always creates it there, whatever the provider's region."
  default     = false
}

variable "spf" {
  type = object({
    mechanisms = optional(list(string), [])
    all        = optional(string, "-all")
  })
  description = "Settings of the SPF record published with Transactional Email. `mechanisms` lists additional SPF mechanisms authorising other services to send mail for the domain, e.g. `include:_spf.google.com` or `ip4:192.0.2.1`, inserted before the final `all`. `all` sets how receivers treat other senders: `-all` (fail, the default), `~all` (softfail) or `?all` (neutral). Requires `setup_tem`."
  default     = null

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
