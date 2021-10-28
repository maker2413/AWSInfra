# --- modules/acm/variables.tf ---

variable "alternative_domains" {
  type = list(string)
}

variable "domain_name" {
  type = string
}

variable "validation_method" {
  type    = string
  default = "DNS"
}
