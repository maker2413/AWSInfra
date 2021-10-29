# --- modules/cloudfront/main.tf ---

resource "aws_cloudfront_distribution" "squids_s3_distribution" {
  origin {
    domain_name = var.domain_name
    origin_id   = var.domain_name
  }

  enabled = true

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.domain_name
    viewer_protocol_policy = "allow-all"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
    }
  }

  tags = {
    Environment = terraform.workspace
    Name        = var.domain_name
    Project     = "Squids"
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_arn
    ssl_support_method  = "sni-only"
  }
}
