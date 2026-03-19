resource "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name = "truittjanney.com."
  type = "A"

  alias {
    name = aws_cloudfront_distribution.prod.domain_name
    zone_id = aws_cloudfront_distribution.prod.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name = "www.truittjanney.com."
  type = "A"

  alias {
    name = aws_cloudfront_distribution.prod.domain_name
    zone_id = aws_cloudfront_distribution.prod.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "dev" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name = "dev.truittjanney.com."
  type = "A"

  alias {
    name = aws_cloudfront_distribution.dev.domain_name
    zone_id = aws_cloudfront_distribution.dev.hosted_zone_id
    evaluate_target_health = false
  }
}
