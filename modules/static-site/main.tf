# --- modules/static-site/main.tf ---

module "static_site_iam" {
  source = "../iam/"
  username = var.iam_username != "" ? var.iam_username : join(
  "-", [join("-", split(".", var.domain, )), "service-account"])

  tags = merge(
    {
      Environment = terraform.workspace
      Module      = "S3StaticSite"
    },
    var.tags,
  )

}

resource "aws_iam_access_key" "static_site_access_key" {
  user = module.static_site_iam.user.name
}

resource "aws_iam_user_policy" "static_site_s3_policy" {
  name = var.s3_policy != "" ? var.s3_policy : join(
  "-", [join("-", split(".", var.domain, )), "service-account-s3-policy"])
  user = module.static_site_iam.user.name

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
      "Resource": "arn:aws:s3:::${var.domain}/*"
    }
  ]
}
EOF
}

module "static_site_s3" {
  source = "../s3"

  acl            = var.s3_acl
  bucket_name    = var.s3_bucket_name != "" ? var.s3_bucket_name : var.domain
  index_document = var.s3_index_document

  tags = merge(
    {
      Name        = var.s3_bucket_name != "" ? var.s3_bucket_name : var.domain
      Environment = terraform.workspace
      Module      = "S3StaticSite"
    },
    var.tags,
  )
}

module "static_site_cloudfront" {
  source = "../cloudfront"

  acm_arn                = var.acm_arn
  aliases                = var.cloudfront_aliases
  domain_name            = module.static_site_s3.bucket_regional_domain_name
  viewer_protocol_policy = var.viewer_protocol_policy

  tags = merge(
    {
      Name        = var.domain
      Environment = terraform.workspace
      Module      = "S3StaticSite"
    },
    var.tags,
  )
}
