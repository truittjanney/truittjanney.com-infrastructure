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
