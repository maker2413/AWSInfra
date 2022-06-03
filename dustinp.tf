# --- notes.tf ---

module "dustinp_iam" {
  source = "./modules/iam/"

  project_tag = "Notes"
  repo_tag    = "github.com/kirigaine/dustinp.me-website"
  username    = "dustinp-service-account"
}

resource "aws_iam_access_key" "dustinp_access_key" {
  user = module.dustinp_iam.user.name
}

resource "aws_iam_user_policy" "dustinp_s3_policy" {
  name = "dustinp-service-account-s3-policy"
  user = module.dustinp_iam.user.name

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
      "Resource": "arn:aws:s3:::www.dustinp.me/*"
    }
  ]
}
EOF
}

module "dustinp_s3" {
  source = "./modules/s3"

  acl            = "public-read"
  bucket_name    = "www.dustinp.me"
  index_document = "index.html"
  project_tag    = "Notes"
  repo_tag       = "github.com/kirigaine/dustinp.me-website"
}

module "dustinp_acm" {
  source = "./modules/acm"

  alternative_domains = ["dustinp.me"]
  domain_name         = "*.dustinp.me"
  name_tag            = "dustinp.me"
  project_tag         = "Notes"
  repo_tag            = "github.com/kirigaine/dustinp.me-website"
  validation_method   = "DNS"
}

module "dustinp_cloudfront" {
  source = "./modules/cloudfront"

  acm_arn     = module.dustinp_acm.acm_arn
  aliases     = ["dustinp.me", "www.dustinp.me"]
  domain_name = module.dustinp_s3.bucket_regional_domain_name
  name_tag    = "dustinp.me"
  project_tag = "Notes"
  repo_tag    = "github.com/kirigaine/dustinp.me-website"
}
