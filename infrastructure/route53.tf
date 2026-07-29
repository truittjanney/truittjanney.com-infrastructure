resource "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "truittjanney.com."
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.prod.domain_name
    zone_id                = aws_cloudfront_distribution.prod.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "www.truittjanney.com."
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.prod.domain_name
    zone_id                = aws_cloudfront_distribution.prod.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "dev" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "dev.truittjanney.com."
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.dev.domain_name
    zone_id                = aws_cloudfront_distribution.dev.hosted_zone_id
    evaluate_target_health = false
  }
}

# Delegate MediaVault DNS management to its separate child hosted zone
resource "aws_route53_record" "mediavault_delegation" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "mediavault.truittjanney.com."
  type    = "NS"
  ttl     = 300

  records = [
    "ns-460.awsdns-57.com.",
    "ns-960.awsdns-56.net.",
    "ns-2023.awsdns-60.co.uk.",
    "ns-1156.awsdns-16.org.",
  ]
}
