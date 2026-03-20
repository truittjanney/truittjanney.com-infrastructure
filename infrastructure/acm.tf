data "aws_route53_zone" "primary" {
  name = "truittjanney.com"
  private_zone = false
}

resource "aws_acm_certificate" "portfolio_cert" {
  provider = aws.us_east_1
  domain_name = "truittjanney.com"
  subject_alternative_names = ["www.truittjanney.com", "*.truittjanney.com"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Truitt Portfolio Certificate"
  }
}

resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true

  for_each = {
    for dvo in aws_acm_certificate.portfolio_cert.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      value = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }

  zone_id = data.aws_route53_zone.primary.zone_id
  name = each.value.name
  type = each.value.type
  records = [each.value.value]
  ttl = 60
}

resource "aws_acm_certificate_validation" "portfolio_cert_validation" {
  provider = aws.us_east_1
  certificate_arn = aws_acm_certificate.portfolio_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
