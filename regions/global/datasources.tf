# --- regions/global/datasources.tf ---

data "terraform_remote_state" "acm" {
  backend = "s3"
  workspace = terraform.workspace
  config = {
    bucket               = "squids-tf-state"
    key                  = "us-west-2.tfstate"
    region               = "us-west-2"
    workspace_key_prefix = "regions"
  }
}
