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
  description = "ID of the project the domain is associated with. Ressource will be created in the region set by the provider if null."
  type        = string
  default     = "null"
}

variable "region" {
  description = "Region in which the domain should be created. Ressource will be created in the region set by the provider if null."
  type        = string
  default     = "null"
}

variable "subdomain" {
  type    = string
  default = ""
}

variable "setup_tem" {
  type    = bool
  default = false
}
