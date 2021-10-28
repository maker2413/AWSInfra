# --- regions/us-west-2/variables.tf ---

variable "alternative_domains" {
  type    = list(string)
  default = ["epost.dev"]
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "domain_name" {
  type    = string
  default = "*.epost.dev"
}

variable "validation_method" {
  type    = string
  default = "DNS"
}
