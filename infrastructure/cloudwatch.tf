############################################
# PROD - 5xx Errors
############################################

resource "aws_cloudwatch_metric_alarm" "prod_5xx" {
  alarm_name = "prod-cloudfront-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 1
  metric_name = "5xxErrorRate"
  namespace = "AWS/CloudFront"
  period = 300
  statistic = "Average"
  threshold = 1

  dimensions = {
    DistributionId = aws_cloudfront_distribution.prod.id
    Region = "Global"
  }

  alarm_description = "High 5xx error rate on production CloudFront"
}

############################################
# PROD - 4xx Errors
############################################

resource "aws_cloudwatch_metric_alarm" "prod_4xx" {
  alarm_name = "prod-cloudfront-4xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 1
  metric_name = "4xxErrorRate"
  namespace = "AWS/CloudFront"
  period = 300
  statistic = "Average"
  threshold = 1

  dimensions = {
    DistributionId = aws_cloudfront_distribution.prod.id
    Region = "Global"
  }

  alarm_description = "High 4xx error rate on production CloudFront"
}

############################################
# DEV - 5xx Errors
############################################

resource "aws_cloudwatch_metric_alarm" "dev_5xx" {
  alarm_name = "dev-cloudfront-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 1
  metric_name = "5xxErrorRate"
  namespace = "AWS/CloudFront"
  period = 300
  statistic = "Average"
  threshold = 1

  dimensions = {
    DistributionId = aws_cloudfront_distribution.dev.id
    Region = "Global"
  }

  alarm_description = "High 5xx error rate on dev CloudFront"
}

############################################
# DEV - 4xx Errors
############################################

resource "aws_cloudwatch_metric_alarm" "dev_4xx" {
  alarm_name = "dev-cloudfront-4xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 1
  metric_name = "4xxErrorRate"
  namespace = "AWS/CloudFront"
  period = 300
  statistic = "Average"
  threshold = 1

  dimensions = {
    DistributionId = aws_cloudfront_distribution.dev.id
    Region = "Global"
  }

  alarm_description = "High 4xx error rate on dev CloudFront"
}
