# --- regions/us-west-2/variables.tf ---

variable "alternative_domains" {
  type    = list(string)
  default = ["ethanp.dev"]
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "domain_name" {
  type    = string
  default = "*.ethanp.dev"
}

variable "validation_method" {
  type    = string
  default = "DNS"
}
