resource "aws_s3_bucket" "portfolio_site" {
    bucket = "truittjanney-website-origin"

    tags = {
        Name = "Truitt Website"
        Environment = "production"
    }
}

resource "aws_s3_bucket_public_access_block" "portfolio_site" {
    bucket = aws_s3_bucket.portfolio_site.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}
