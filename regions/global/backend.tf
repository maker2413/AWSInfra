# --- regions/global/backend.tf ---

terraform {
  backend "s3" {
    bucket               = "squids-tf-state"
    encrypt              = true
    key                  = "global.tfstate"
    region               = "us-west-2"
    workspace_key_prefix = "regions"
  }
}
