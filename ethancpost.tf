# --- ethancpost.tf ---

module "ethancpost_iam" {
  source = "./modules/iam/"

  username    = "ethancpost-service-account"

  tags = {
    Project = "Website"
    Repo    = "github.com/maker2413/Website"
  }
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

  tags = {
    Name    = "www.ethancpost.com"
    Project = "Website"
    Repo    = "github.com/maker2413/Website"
  }
}

module "ethancpost_acm" {
  source = "./modules/acm"

  alternative_domains = ["ethancpost.com"]
  domain_name         = "*.ethancpost.com"
  validation_method   = "DNS"

  tags = {
    Name      = "ethancpost.com"
    Project   = "Website"
    Repo      = "github.com/maker2413/Website"
  }
}

module "ethancpost_cloudfront" {
  source = "./modules/cloudfront"

  acm_arn     = module.ethancpost_acm.acm_arn
  aliases     = ["ethancpost.com", "www.ethancpost.com"]
  domain_name = module.ethancpost_s3.bucket_regional_domain_name

  tags = {
    Name    = "ethancpost.com"
    Project = "Website"
    Repo    = "github.com/maker2413/Website"
  }
}

module "notes_iam" {
  source = "./modules/iam/"

  username    = "notes-service-account"

  tags = {
    Project = "Notes"
    Repo    = "github.com/maker2413/Notes"
  }
}

resource "aws_iam_access_key" "notes_access_key" {
  user = module.notes_iam.user.name
}

resource "aws_iam_user_policy" "notes_s3_policy" {
  name = "notes-service-account-s3-policy"
  user = module.notes_iam.user.name

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
      "Resource": "arn:aws:s3:::notes.ethancpost.com/*"
    }
  ]
}
EOF
}

module "notes_s3" {
  source = "./modules/s3"

  acl            = "public-read"
  bucket_name    = "notes.ethancpost.com"
  index_document = "index.html"

  tags = {
    Name    = "notes.ethancpost.com"
    Project = "Notes"
    Repo    = "github.com/maker2413/Notes"
  }
}

module "notes_cloudfront" {
  source = "./modules/cloudfront"

  acm_arn     = module.ethancpost_acm.acm_arn
  aliases     = ["notes.ethancpost.com"]
  domain_name = module.notes_s3.bucket_regional_domain_name

  tags = {
    Name    = "ethanp.dev"
    Project = "Notes"
    Repo    = "github.com/maker2413/Notes"
  }
}
