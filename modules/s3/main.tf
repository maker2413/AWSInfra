# --- modules/s3/main.tf ---

resource "aws_s3_bucket" "squids_s3" {
  bucket = var.bucket_name
  acl    = var.acl

  tags = {
    Name        = var.bucket_name
    Environment = terraform.workspace
    Project     = "Squids"
  }
}
