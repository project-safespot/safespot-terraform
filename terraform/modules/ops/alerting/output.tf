output "sns_topic_arn" {
  value = aws_sns_topic.ops_alert.arn
}

output "sns_topic_name" {
  value = aws_sns_topic.ops_alert.name
}

output "slack_webhook_secret_arn" {
  description = "SSM Parameter ARN (콘솔에서 직접 값 입력 필요)"
  value       = var.enable_slack_secret ? "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${local.slack_secret_name}" : null
}

output "slack_webhook_secret_name" {
  description = "SSM Parameter 이름 (콘솔에서 직접 값 입력 필요)"
  value       = var.enable_slack_secret ? local.slack_secret_name : null
}

output "alertmanager_secret_read_policy_arn" {
  value = var.enable_slack_secret ? aws_iam_policy.alertmanager_secret_read[0].arn : null
}
