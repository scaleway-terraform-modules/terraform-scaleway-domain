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

variable "subdomain" {
  type    = string
  default = ""
}

variable "setup_tem" {
  type    = bool
  default = false
}
