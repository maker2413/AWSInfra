# --- notes.tf ---

module "iam" {
  source = "./modules/iam/"

  project_tag = "Notes"
  repo_tag    = "github.com/maker2413/Notes"
  username    = "notes-service-account"
}

resource "aws_iam_access_key" "notes_access_key" {
  user = module.iam.user.name
}

resource "aws_iam_user_policy" "notes_s3_policy" {
  name = "notes-service-account-s3-policy"
  user = module.iam.user.name

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

module "s3" {
  source = "./modules/s3"

  acl            = "public-read"
  bucket_name    = "www.ethanp.dev"
  index_document = "index.html"
  project_tag    = "Notes"
  repo_tag       = "github.com/maker2413/Notes"
}

module "acm" {
  source = "./modules/acm"

  alternative_domains = ["ethanp.dev"]
  domain_name         = "*.ethanp.dev"
  name_tag            = "ethanp.dev"
  project_tag         = "Notes"
  repo_tag            = "github.com/maker2413/Notes"
  validation_method   = "DNS"
}

module "cloudfront" {
  source = "./modules/cloudfront"

  acm_arn     = module.acm.acm_arn
  aliases     = ["ethanp.dev", "www.ethanp.dev"]
  domain_name = module.s3.bucket_regional_domain_name
  name_tag    = "ethanp.dev"
  project_tag = "Notes"
  repo_tag    = "github.com/maker2413/Notes"
}
