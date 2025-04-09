# --- bootdev.tf ---

resource "random_integer" "first" {
  min = 1
  max = 50000
}

resource "random_integer" "second" {
  min = 1
  max = 50000
}

resource "aws_s3_bucket" "tubely" {
  bucket = "tubely-${random_integer.first.result}-${random_integer.second.result}"
}

resource "aws_s3_bucket_public_access_block" "tubely" {
  bucket = aws_s3_bucket.tubely.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "tubely" {
  bucket = aws_s3_bucket.tubely.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_policy" "tubely" {
  bucket = aws_s3_bucket.tubely.id
  policy = data.aws_iam_policy_document.tubely.json
}

data "aws_iam_policy_document" "tubely" {
  statement {
    principals {
      type = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.tubely.id}/*"
    ]
  }
}
