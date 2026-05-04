# modules/ops/cloudwatch/locals.tf

locals {
  project     = "safespot"
  domain      = "ops"
  name_prefix = "${local.project}-${var.env}-${local.domain}"

  # evaluation_periods, period는 각 alarm 파일에서 성격에 맞게 개별 설정한다.
  # - 즉각 반응: DLQ, Lambda throttle → evaluation_periods = 1
  # - 연속 초과 확인: CPU, memory, latency, connection → evaluation_periods = 3
  # - 중간: 5xx, 4xx, backlog → evaluation_periods = 2

  alarm_actions = [var.sns_topic_arn]

  # ok_actions 정책:
  # - DLQ, Lambda throttle처럼 "해소 확인이 중요한 알람"만 ok_actions에 SNS를 건다.
  # - CPU, memory, latency, connection 계열은 ok_actions = []로 설정한다.
  #   재난 상황에서 알람 트리거/해소 반복 시 알림 폭탄 방지.
  # - 각 alarm 리소스에서 ok_actions를 직접 지정한다.
  #   ok_actions가 필요한 알람: local.alarm_actions 사용
  #   ok_actions가 불필요한 알람: []
  critical_ok_actions = [var.sns_topic_arn]

  has_alb        = var.alb_arn_suffix != null && trimspace(var.alb_arn_suffix) != ""
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