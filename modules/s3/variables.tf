# --- modules/s3/variables.tf ---

variable "acl" {
  type    = string
  default = "private"
}

variable "bucket_name" {
  type = string
}

variable "index_document" {
  type    = string
  default = "index.html"
}
