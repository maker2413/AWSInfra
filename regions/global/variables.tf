# --- regions/global/variables.tf ---

variable "acl" {
  type    = string
  default = "public-read"
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "bucket_name" {
  type    = string
  default = "www.ethancpost.com"
}
