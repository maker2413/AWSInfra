# --- Compute/backend.tf ---

terraform {
  backend "s3" {
    bucket  = "squids-terraform-state"
    encrypt = true

    key                  = "terraform.tfstate"
    workspace_key_prefix = "Compute"

    region = "us-west-2"
  }
}
