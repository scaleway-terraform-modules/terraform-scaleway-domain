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
  description = "URL of the log that should be used for BIMI. The file must be a SVG document and follow [BIMI specifications](https://bimigroup.org/creating-bimi-svg-logo-files/)."
  default     = ""
}

variable "bimi_vmc_url" {
  type        = string
  description = "URL of the Verified Mark Certificate or Common Mark Certificate."
  default     = ""
}

variable "mx_servers" {
  description = "Informations regarding MX servers. **MX servers are required to enable Transactional Emails.**"
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
  description = "ID of the project the domain is associated with. Ressource will be created in the project set at the provider level if null."
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
  description = "Whether to create a Transaction Email service. **Beware that the service is only available in region `fr-par` at the moment.**"
  default     = false
}
