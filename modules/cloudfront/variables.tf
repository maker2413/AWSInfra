# --- modules/cloudfront/variables.tf ---

variable "acm_arn" {
  type = string
}

variable "aliases" {
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

variable "restriction_type" {
  type    = string
  default = "none"
}

variable "root_object" {
  type    = string
  default = "index.html"
}
