# --- regions/us-west-1/vpc.tf ---

module "vpc" {
  source = "../../modules/vpc/"

  providers = {
    aws = aws
  }
}
