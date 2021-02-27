# --- regions/us-west-2/vpc.tf ---

module "vpc" {
  source = "../../modules/vpc/"

  providers = {
    aws = aws
  }
}
