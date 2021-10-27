# --- regions/global/s3.tf ---

module "s3" {
  source = "../../modules/s3/"

  acl            = var.acl
  bucket_name    = var.bucket_name
  index_document = var.index_document

  providers = {
    aws = aws
  }
}
