# --- clintahenrichs.tf ---

module "clintahenrichs_acm" {
  source = "./modules/acm"

  alternative_domains = ["clintahenrichs.com"]
  domain_name         = "*.clintahenrichs.com"
  validation_method   = "DNS"

  tags = {
    Name    = "clintahenrichs.com"
    Project = "Website"
    Repo    = "github.com/maker2413/Website"
  }
}

module "clintahenrichs" {
  source = "./modules/static-site"

  acm_arn            = module.clintahenrichs_acm.acm_arn
  cloudfront_aliases = ["clintahenrichs.com", "www.clintahenrichs.com"]
  domain             = "www.clintahenrichs.com"

  tags = {
    Project = "Website"
    Repo    = "github.com/maker2413/Website"
  }
}
