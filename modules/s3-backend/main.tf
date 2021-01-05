resource "aws_s3_bucket" "tf_bucket" {
  bucket_prefix = "${var.bucket_name}"
  region = "${var.aws_region}"
  tags = "${merge(map("Name", "${var.bucket_name}"), var.tags)}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
	kms_master_key_id = "${aws_kms_key.tf_bucket.arn}"
	sse_algorithm = "aws:kms"
      }
    }
  }
}

# Note 
resource "aws_s3_bucket_policy" 
