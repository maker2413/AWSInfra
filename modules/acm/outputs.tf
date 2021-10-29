# --- modules/acm/outputs.tf ---

output "acm_arn" {
  value = aws_acm_certificate.squids_acm.arn
}
