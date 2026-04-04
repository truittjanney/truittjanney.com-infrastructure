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
  alarm_actions = [aws_sns_topic.cloudwatch_alerts.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alerts.arn]
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
  alarm_actions = [aws_sns_topic.cloudwatch_alerts.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alerts.arn]
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
  alarm_actions = [aws_sns_topic.cloudwatch_alerts.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alerts.arn]
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
  alarm_actions = [aws_sns_topic.cloudwatch_alerts.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alerts.arn]
}
