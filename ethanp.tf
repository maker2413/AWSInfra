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

module "notes_ethanp_iam" {
  source = "./modules/iam/"

  username    = "notes-ethanp-service-account"

  tags = {
    Project = "Notes"
    Repo    = "github.com/maker2413/Notes"
  }
}

resource "aws_iam_access_key" "notes_ethanp_access_key" {
  user = module.notes_ethanp_iam.user.name
}

resource "aws_iam_user_policy" "notes_ethanp_s3_policy" {
  name = "notes-ethanp-service-account-s3-policy"
  user = module.notes_ethanp_iam.user.name

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
      "Resource": "arn:aws:s3:::notes.ethanp.dev/*"
    }
  ]
}
EOF
}

module "notes_ethanp_s3" {
  source = "./modules/s3"

  acl            = "public-read"
  bucket_name    = "notes.ethanp.dev"
  index_document = "index.html"

  tags = {
    Name    = "notes.ethanp.dev"
    Project = "Notes"
    Repo    = "github.com/maker2413/Notes"
  }
}

module "notes_ethanp_cloudfront" {
  source = "./modules/cloudfront"

  acm_arn     = module.ethanp_acm.acm_arn
  aliases     = ["notes.ethanp.dev"]
  domain_name = module.notes_ethanp_s3.bucket_regional_domain_name
  viewer_protocol_policy = "redirect-to-https"

  tags = {
    Name    = "notes.ethanp.dev"
    Project = "Notes"
    Repo    = "github.com/maker2413/Notes"
  }
}

module "blog_ethanp_iam" {
  source = "./modules/iam/"

  username    = "blog-ethanp-service-account"

  tags = {
    Project = "Blog"
    Repo    = "github.com/maker2413/Blog"
  }
}

resource "aws_iam_access_key" "blog_ethanp_access_key" {
  user = module.blog_ethanp_iam.user.name
}

resource "aws_iam_user_policy" "blog_ethanp_s3_policy" {
  name = "blog-ethanp-service-account-s3-policy"
  user = module.blog_ethanp_iam.user.name

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
      "Resource": "arn:aws:s3:::blog.ethanp.dev/*"
    }
  ]
}
EOF
}

module "blog_ethanp_s3" {
  source = "./modules/s3"

  acl            = "public-read"
  bucket_name    = "blog.ethanp.dev"
  index_document = "index.html"

  tags = {
    Name    = "blog.ethanp.dev"
    Project = "Blog"
    Repo    = "github.com/maker2413/Blog"
  }
}

module "blog_ethanp_cloudfront" {
  source = "./modules/cloudfront"

  acm_arn     = module.ethanp_acm.acm_arn
  aliases     = ["blog.ethanp.dev"]
  domain_name = module.blog_ethanp_s3.bucket_regional_domain_name
  viewer_protocol_policy = "redirect-to-https"

  tags = {
    Name    = "blog.ethanp.dev"
    Project = "Blog"
    Repo    = "github.com/maker2413/Blog"
  }
}
