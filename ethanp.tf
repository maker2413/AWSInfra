# --- ethanp.tf ---

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

module "ethanp" {
  source = "./modules/static-site"

  acm_arn            = module.ethanp_acm.acm_arn
  cloudfront_aliases = ["ethanp.dev", "www.ethanp.dev"]
  domain             = "www.ethanp.dev"

  tags = {
    Project = "Website"
    Repo    = "github.com/maker2413/Website"
  }
}

module "ethanp_notes" {
  source = "./modules/static-site"

  acm_arn            = module.ethanp_acm.acm_arn
  cloudfront_aliases = ["notes.ethanp.dev"]
  domain             = "notes.ethanp.dev"

  tags = {
    Project = "Notes"
    Repo    = "github.com/maker2413/Notes"
  }
}

module "ethanp_blog" {
  source = "./modules/static-site"

  acm_arn            = module.ethanp_acm.acm_arn
  cloudfront_aliases = ["blog.ethanp.dev"]
  domain             = "blog.ethanp.dev"

  tags = {
    Project = "Blog"
    Repo    = "github.com/maker2413/Blog"
  }
}

module "ethanp_emacs" {
  source = "./modules/static-site"

  acm_arn            = module.ethanp_acm.acm_arn
  cloudfront_aliases = ["emacs.ethanp.dev"]
  domain             = "emacs.ethanp.dev"

  tags = {
    Project = "Emacs"
    Repo    = "github.com/maker2413/Emacs"
  }
}
