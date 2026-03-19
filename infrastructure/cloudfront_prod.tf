############################################
# Origin Access Control
############################################

resource "aws_cloudfront_origin_access_control" "portfolio_oac" {
  name = "portfolio-oac"
  description = "OAC for Truitt portfolio site"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

############################################
# CloudFront Distribution
############################################

resource "aws_cloudfront_distribution" "prod" {

  enabled = true
  default_root_object = "index.html"

  aliases = [
    "truittjanney.com",
    "www.truittjanney.com"
  ]

  origin {
    domain_name = aws_s3_bucket.prod.bucket_regional_domain_name
    origin_id = "s3-portfolio-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.portfolio_oac.id
  }

  default_cache_behavior {
    target_origin_id = "s3-portfolio-origin"
    viewer_protocol_policy = "redirect-to-https"
    compress = true

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.portfolio_cert.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_100"

  tags = {
    Name = "Truitt Portfolio CDN"
    Environment = "production"
  }
}

############################################
# Allow CloudFront to access S3 bucket
############################################

resource "aws_s3_bucket_policy" "portfolio_policy" {
  bucket = aws_s3_bucket.prod.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.prod.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.prod.arn
          }
        }
      }
    ]
  })
}
