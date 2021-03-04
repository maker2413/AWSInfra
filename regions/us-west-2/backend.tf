# --- regions/us-west-2/backend.tf ---

terraform {
  backend "s3" {
    bucket               = "squids-tf-state"
    encrypt              = true
    key                  = "us-west-2.tfstate"
    region               = "us-west-2"
    workspace_key_prefix = "regions"
  }
}
