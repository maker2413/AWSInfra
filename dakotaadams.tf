# --- dakotaadams.tf ---

module "dakotaadams_acm" {
  source = "./modules/acm"

  alternative_domains = ["dakotaadams.tech"]
  domain_name         = "*.dakotaadams.tech"
  validation_method   = "DNS"

  tags = {
    Name    = "dakotaadams.tech"
    Project = "Notes"
    Repo    = "github.com/DakotaAd13/Website"
  }
}

module "dakotaadams" {
  source = "./modules/static-site"

  acm_arn            = module.dakotaadams_acm.acm_arn
  cloudfront_aliases = ["dakotaadams.tech", "www.dakotaadams.tech"]
  domain             = "www.dakotaadams.tech"

  tags = {
    Project = "Website"
    Repo    = "github.com/DakotaAd13/Website"
  }
}
