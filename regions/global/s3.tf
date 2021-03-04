# --- regions/global/s3.tf ---

module "s3" {
  source = "../../modules/s3/"

  providers = {
    aws = aws
  }
}
