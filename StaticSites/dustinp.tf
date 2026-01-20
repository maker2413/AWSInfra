# --- StaticSites/dustinp.tf ---

module "dustinp_acm" {
  source = "../modules/acm"

  alternative_domains = ["dustinp.me"]
  domain_name         = "*.dustinp.me"
  validation_method   = "DNS"

  tags = {
    Name    = "dustinp.me"
    Project = "Notes"
    Repo    = "github.com/kirigaine/dustinp.me-website"
  }
}

module "dustinp" {
  source = "../modules/static-site"

  acm_arn            = module.dustinp_acm.acm_arn
  cloudfront_aliases = ["dustinp.me", "www.dustinp.me"]
  domain             = "www.dustinp.me"

  tags = {
    Project = "Website"
    Repo    = "github.com/kirigaine/dustinp.me-website"
  }
}
