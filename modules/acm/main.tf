# --- modules/acm/main.tf ---

provider "aws" {
  region = var.aws_region
}

resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  subject_alternative_names = var.alternative_domains
  validation_method         = var.validation_method

  tags = merge(
    {
      Environment = terraform.workspace
      Module      = "acm"
    },
    var.tags,
  )
}
