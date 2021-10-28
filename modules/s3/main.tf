# --- modules/s3/main.tf ---

resource "aws_s3_bucket" "squids_s3" {
  acl    = var.acl
  bucket = var.bucket_name

  website {
    index_document = var.index_document
  }

  tags = {
    Environment = terraform.workspace
    Name        = var.bucket_name
    Project     = "Squids"
  }
}

resource "aws_s3_bucket_policy" "squids_s3_policy" {
  bucket = aws_s3_bucket.squids_s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "${upper(var.bucket_name)}POLICY"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.squids_s3.arn,
          "${aws_s3_bucket.squids_s3.arn}/*",
        ]
      },
    ]
  })
}
