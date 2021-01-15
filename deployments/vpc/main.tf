terraform {
  backend "s3" {
    bucket = "squids-tf-states"
    key = "network/vpc/terraform.tfstate"
    region = "us-west-2"
    encrypt = true
    kms_key_id = "tf-s3"
  }
}
