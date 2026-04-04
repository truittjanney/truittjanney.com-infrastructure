resource "aws_sns_topic" "cloudwatch_alerts" {
  name = "cloudwatch-alerts"
}

resource "aws_sns_topic_subscription" "email_alerts" {
  topic_arn = aws_sns_topic.cloudwatch_alerts.arn
  protocol  = "email"
  endpoint  = "truittjanney93@gmail.com"
}
