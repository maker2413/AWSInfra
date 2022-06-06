# --- ethanp.tf ---

module "ethanp_iam" {
  source = "./modules/iam/"

  username    = "ethanp-service-account"

  tags = {
    Project = "Website"
    Repo    = "github.com/maker2413/Website"
  }
}

resource "aws_iam_access_key" "ethanp_access_key" {
  user = module.ethanp_iam.user.name
}

resource "aws_iam_user_policy" "ethanp_s3_policy" {
  name = "ethanp-service-account-s3-policy"
  user = module.ethanp_iam.user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ObjectLevel",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": "arn:aws:s3:::www.ethanp.dev/*"
    }
  ]
}
EOF
}

module "ethanp_s3" {
  source = "./modules/s3"

  acl            = "public-read"
  bucket_name    = "www.ethanp.dev"
  index_document = "index.html"

  tags = {
    Name    = "www.ethanp.dev"
    Project = "Notes"
    Repo    = "github.com/maker2413/Notes"
  }
}

module "ethanp_acm" {
  source = "./modules/acm"

  alternative_domains = ["ethanp.dev"]
  domain_name         = "*.ethanp.dev"
  validation_method   = "DNS"

  tags = {
    Name    = "ethanp.dev"
    Project = "Notes"
    Repo    = "github.com/maker2413/Notes"
  }
}

module "ethanp_cloudfront" {
  source = "./modules/cloudfront"

  acm_arn     = module.ethanp_acm.acm_arn
  aliases     = ["ethanp.dev", "www.ethanp.dev"]
  domain_name = module.ethanp_s3.bucket_regional_domain_name

  tags = {
    Name    = "ethanp.dev"
    Project = "Notes"
    Repo    = "github.com/maker2413/Notes"
  }
}
