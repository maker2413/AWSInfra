# --- regions/global/cloudfront.tf ---

module "cloudfront" {
  source = "../../modules/cloudfront/"

  acm_arn     = data.terraform_remote_state.acm.outputs.acm_arn
  domain_name = module.s3.bucket_regional_domain_name
}
