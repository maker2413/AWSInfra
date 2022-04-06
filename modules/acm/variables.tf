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

variable "name_tag" {
  type = string
}

variable "project_tag" {
  type = string
}

variable "repo_tag" {
  type = string
}

variable "validation_method" {
  type    = string
  default = "DNS"
}
