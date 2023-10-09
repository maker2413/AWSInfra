# --- ethancpost.tf ---

module "ethancpost_acm" {
  source = "./modules/acm"

  alternative_domains = ["ethancpost.com"]
  domain_name         = "*.ethancpost.com"
  validation_method   = "DNS"

  tags = {
    Name    = "ethancpost.com"
    Project = "Website"
    Repo    = "github.com/maker2413/Website"
  }
}

module "ethancpost" {
  source = "./modules/static-site"

  acm_arn            = module.ethancpost_acm.acm_arn
  cloudfront_aliases = ["ethancpost.com", "www.ethancpost.com"]
  domain             = "www.ethancpost.com"

  tags = {
    Project = "Website"
    Repo    = "github.com/maker2413/Website"
  }
}

module "ethancpost_notes" {
  source = "./modules/static-site"

  acm_arn            = module.ethancpost_acm.acm_arn
  cloudfront_aliases = ["notes.ethancpost.com"]
  domain             = "notes.ethancpost.com"

  tags = {
    Project = "Notes"
    Repo    = "github.com/maker2413/Notes"
  }
}

module "ethancpost_blog" {
  source = "./modules/static-site"

  acm_arn            = module.ethancpost_acm.acm_arn
  cloudfront_aliases = ["blog.ethancpost.com"]
  domain             = "blog.ethancpost.com"

  tags = {
    Project = "Blog"
    Repo    = "github.com/maker2413/Blog"
  }
}

module "ethancpost_emacs" {
  source = "./modules/static-site"

  acm_arn            = module.ethancpost_acm.acm_arn
  cloudfront_aliases = ["emacs.ethancpost.com"]
  domain             = "emacs.ethancpost.com"

  tags = {
    Project = "Emacs"
    Repo    = "github.com/maker2413/Emacs"
  }
}
