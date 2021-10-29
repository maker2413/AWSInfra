# --- modules/s3/outputs.tf ---

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.squids_s3.bucket_regional_domain_name
}
