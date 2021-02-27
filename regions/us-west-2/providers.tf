# --- regions/us-west-2/providers.tf ---

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.provider_region
}
