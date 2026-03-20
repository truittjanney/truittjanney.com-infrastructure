resource "aws_cloudfront_distribution" "dev" {
  enabled = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.dev.bucket_regional_domain_name
    origin_id   = "s3-dev-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.portfolio_oac.id
  }

  default_cache_behavior {
    target_origin_id = "s3-dev-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }
  }

aliases = ["dev.truittjanney.com"]

viewer_certificate {
  acm_certificate_arn      = aws_acm_certificate.portfolio_cert.arn
  ssl_support_method       = "sni-only"
  minimum_protocol_version = "TLSv1.2_2021"
}

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
