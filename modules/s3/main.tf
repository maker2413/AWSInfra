# --- modules/s3/main.tf ---

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = merge(
    {
      Environment = terraform.workspace
      Module      = "s3"
    },
    var.tags,
  )
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id

  acl = var.acl
}

resource "aws_s3_bucket_website_configuration" "bucket_website_configuration" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.index_document
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

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
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*",
        ]
      },
    ]
  })
}
