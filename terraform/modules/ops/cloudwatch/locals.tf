locals {
  project     = "safespot"
  domain      = "ops"
  name_prefix = "${local.project}-${var.environment}-${local.domain}"

  alarm_actions       = [var.sns_topic_arn]
  critical_ok_actions = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  default_evaluation_periods = 3
  default_period             = 60

  # [삭제] has_alb = var.alb_arn_suffix 제거
  has_rds        = var.rds_cluster_identifier != null && trimspace(var.rds_cluster_identifier) != ""
  has_redis      = var.redis_cluster_id != null && trimspace(var.redis_cluster_id) != ""
  has_lambda     = var.lambda_function_name != null && trimspace(var.lambda_function_name) != ""
  has_eks        = var.eks_cluster_name != null && trimspace(var.eks_cluster_name) != ""
  has_cloudfront = var.cloudfront_distribution_id != null && trimspace(var.cloudfront_distribution_id) != ""
  has_waf        = var.waf_acl_name != null && trimspace(var.waf_acl_name) != ""

  sqs_main_queues = {
    for k, v in {
      cache_refresh = var.sqs_queue_names.cache_refresh
      readmodel     = var.sqs_queue_names.readmodel
      env_cache     = var.sqs_queue_names.env_cache
    } : k => v if v != null && trimspace(v) != ""
  }

  has_dlq = var.sqs_queue_names.dlq != null && trimspace(var.sqs_queue_names.dlq) != ""
}
