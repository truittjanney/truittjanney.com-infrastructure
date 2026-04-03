resource "aws_s3_bucket" "dev" {
  bucket = "truittjanney-website-dev"

  tags = {
    Name = "Truitt Website Dev"
    Environment = "dev"
  }
}

resource "aws_s3_bucket" "prod" {
  bucket = "truittjanney-website-prod"

  tags = {
    Name = "Truitt Website Prod"
    Environment = "prod"
  }
}

resource "aws_s3_bucket_public_access_block" "dev" {
  bucket = aws_s3_bucket.dev.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod" {
  bucket = aws_s3_bucket.prod.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "dev_policy" {
  bucket = aws_s3_bucket.dev.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.dev.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "cloudfront_logs" {
  bucket = "truittjanney-cloudfront-logs"

  tags = {
    Name = "CloudFront Logs"
    Environment = "shared"
  }
}

resource "aws_s3_bucket_ownership_controls" "logs" {
  bucket = aws_s3_bucket.cloudfront_logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.cloudfront_logs.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = false
  restrict_public_buckets = true
}
