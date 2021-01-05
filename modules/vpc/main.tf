terraform {
  backend "s3" {
    bucket = "squids-tf-states"
    key = ""
    region = "us-west-2"
  }
}
