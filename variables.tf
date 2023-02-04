variable "domain" {
  type = string
}

variable "mx_servers" {
  type = list(object({
    address  = string
    priority = number
  }))
  default = [{
    address  = "."
    priority = 0
  }]
}

variable "project_id" {
  description = "ID of the project the domain is associated with. Ressource will be created in the project set at the provider level if null."
  type        = string
  default     = null
}

variable "subdomain" {
  type    = string
  default = ""
}

variable "setup_tem" {
  type        = bool
  description = "Whether to create a Transaction Email service. **Beware that the service is only available in region `fr-par` at the moment.**"
  default     = false
}
