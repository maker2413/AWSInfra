# --- backend.tf ---

terraform {
  backend "s3" {
    bucket               = "squids-terraform-state"
    encrypt              = true
    key                  = "squids-aws.tfstate"
    region               = "us-west-2"
  }
}
