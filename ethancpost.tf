# --- ethancpost.tf ---

module "ethancpost_iam" {
  source = "./modules/iam/"

  project_tag = "Website"
  repo_tag    = "github.com/maker2413/Website"
  username    = "ethancpost-service-account"
}

resource "aws_iam_access_key" "ethancpost_access_key" {
  user = module.ethancpost_iam.user.name
}

resource "aws_iam_user_policy" "ethancpost_s3_policy" {
  name = "ethancpost-service-account-s3-policy"
  user = module.ethancpost_iam.user.name

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
      "Resource": "arn:aws:s3:::www.ethancpost.com/*"
    }
  ]
}
EOF
}

module "ethancpost_s3" {
  source = "./modules/s3"

  acl            = "public-read"
  bucket_name    = "www.ethancpost.com"
  index_document = "index.html"
  project_tag    = "Website"
  repo_tag       = "github.com/maker2413/Website"
}

module "ethancpost_acm" {
  source = "./modules/acm"

  alternative_domains = ["ethancpost.com"]
  domain_name         = "*.ethancpost.com"
  name_tag            = "ethancpost.com"
  project_tag         = "Website"
  repo_tag            = "github.com/maker2413/Website"
  validation_method   = "DNS"
}

module "ethancpost_cloudfront" {
  source = "./modules/cloudfront"

  acm_arn     = module.ethancpost_acm.acm_arn
  aliases     = ["ethancpost.com", "www.ethancpost.com"]
  domain_name = module.ethancpost_s3.bucket_regional_domain_name
  name_tag    = "ethancpost.com"
  project_tag = "Website"
  repo_tag    = "github.com/maker2413/Website"
}
