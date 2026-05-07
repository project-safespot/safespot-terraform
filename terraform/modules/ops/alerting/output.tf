output "sns_topic_arn" {
  value = aws_sns_topic.ops_alert.arn
}

output "sns_topic_name" {
  value = aws_sns_topic.ops_alert.name
}

output "slack_webhook_secret_arn" {
  value = var.enable_slack_secret ? aws_ssm_parameter.slack_webhook[0].arn : null
}

output "slack_webhook_secret_name" {
  value = var.enable_slack_secret ? aws_ssm_parameter.slack_webhook[0].name : null
}

output "alertmanager_secret_read_policy_arn" {
  value = var.enable_slack_secret ? aws_iam_policy.alertmanager_secret_read[0].arn : null
}
