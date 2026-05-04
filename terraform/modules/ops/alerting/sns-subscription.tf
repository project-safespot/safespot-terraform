resource "aws_sns_topic_subscription" "email" {
  for_each = toset(local.all_email_subscriptions)

  topic_arn = aws_sns_topic.ops_alert.arn
  protocol  = "email"
  endpoint  = each.value
}