# --- modules/acm/main.tf ---

resource "aws_acm_certificate" "squids_acm" {
  domain_name               = var.domain_name
  subject_alternative_names = var.alternative_domains
  validation_method         = var.validation_method

  tags = {
    Environment = terraform.workspace
    Project     = "Squids"
  }
}
