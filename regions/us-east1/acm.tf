# --- regions/us-west-2/acm.tf ---

module "acm" {
  source = "../../modules/acm/"

  alternative_domains = var.alternative_domains

  domain_name         = var.domain_name
  validation_method   = var.validation_method

  providers = {
    aws = aws
  }
}
