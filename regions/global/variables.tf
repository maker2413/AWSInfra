# --- regions/global/variables.tf ---

variable "acl" {
  type    = string
  default = "public-read"
}

variable "alias" {
  type    = string
  default = "ethanp.dev"
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "bucket_name" {
  type    = string
  default = "www.ethanp.dev"
}

variable "index_document" {
  type    = string
  default = "README.html"
}
