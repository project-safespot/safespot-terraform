output "ecr_repository_urls" {
  value = module.ecr.repository_urls
}

output "ecr_repository_arns" {
  value = module.ecr.repository_arns
}

output "ops_sns_topic_arn" {
  value = module.alerting.sns_topic_arn
}

output "slack_webhook_secret_arn" {
  value = module.alerting.slack_webhook_secret_arn
}

output "alertmanager_secret_read_policy_arn" {
  value = module.alerting.alertmanager_secret_read_policy_arn
}

output "cloudwatch_alarm_arns" {
  value = module.cloudwatch.alarm_arns
}

output "log_group_names" {
  value = module.log_groups.app_log_group_names
}

output "log_group_arns" {
  value = module.log_groups.app_log_group_arns
}

output "lambda_log_group_arn" {
  value = module.log_groups.lambda_log_group_arn
}

output "eks_control_plane_log_group_name" {
  value = module.log_groups.eks_control_plane_log_group_name
}

output "irsa_role_arns" {
  value = var.enable_observability_iam ? module.observability_iam[0].irsa_role_arns : null
}

output "cloudwatch_read_policy_arn" {
  value = var.enable_observability_iam ? module.observability_iam[0].cloudwatch_read_policy_arn : null
}