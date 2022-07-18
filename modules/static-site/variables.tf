# --- modules/static-site/variables.tf

variable "acm_arn" {
  type    = string
  default = ""
}

variable "cloudfront_aliases" {
  type    = list(string)
}

variable "domain" {
  type    = string
  default = ""
}

variable "iam_username" {
  type    = string
  default = ""
}

variable "s3_acl" {
  type    = string
  default = "public-read"
}

variable "s3_index_document" {
  type    = string
  default = "index.html"
}

variable "s3_bucket_name" {
  type    = string
  default = ""
}

variable "s3_policy" {
  type    = string
  default = ""
}

variable "tags" {
  type = map(string)
}

variable "viewer_protocol_policy" {
  type    = string
  default = "redirect-to-https"
}
