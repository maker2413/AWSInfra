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

variable "tags" {
  type = map(string)
}

variable "restriction_type" {
  type    = string
  default = "none"
}

variable "root_object" {
  type    = string
  default = "index.html"
}

variable "viewer_protocol_policy" {
  type    = string
  default = "allow-all"
}
