# --- bootdev.tf ---

resource "random_integer" "first" {
  min = 1
  max = 50000
}

resource "random_integer" "second" {
  min = 1
  max = 50000
}

resource "random_integer" "third" {
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

resource "aws_iam_policy" "tubely_s3" {
  name = "tubely-s3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "VisualEditor0",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.tubely.id}",
          "arn:aws:s3:::${aws_s3_bucket.tubely.id}/*"]
      }
    ]
  })
}

resource "aws_iam_role" "tubely" {
  name = "tubely-app"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "tubely" {
  role = aws_iam_role.tubely.id
  policy_arn = aws_iam_policy.tubely_s3.id
}

resource "aws_iam_policy" "tubely" {
  name = "manager-from-home"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "*",
        Resource = "*",
        Condition = {
          IpAddress = {
            "aws:SourceIp": "0.0.0.0/32"
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket" "tubely_private" {
  bucket = "tubely-private-${random_integer.third.result}"
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
