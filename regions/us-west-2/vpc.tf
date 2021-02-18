terraform {
  backend "s3" {
    bucket = "squids-tf-state"
    key = "network/vpc/terraform.tfstate"
    region = "us-west-2"
    encrypt = true
    kms_key_id = "tf-s3"
  }
}

provider "aws" {
  region = var.provider_region
}

module "vpc" {
  source = "../../modules/vpc/"

  providers = {
    aws = aws
  }
}
