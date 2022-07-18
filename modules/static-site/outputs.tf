# --- modules/static-site/outputs.tf ---

output "iam_access_key" {
  value = aws_iam_access_key.static_site_access_key
}
