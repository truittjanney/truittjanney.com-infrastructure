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

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
