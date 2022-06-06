# --- modules/acm/variables.tf ---

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "alternative_domains" {
  type = list(string)
}

variable "domain_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "validation_method" {
  type    = string
  default = "DNS"
}
