output "alarm_arns" {
  description = "생성된 CloudWatch Alarm ARN 전체 map"

  value = merge(
    local.has_alb ? {
      alb_5xx     = aws_cloudwatch_metric_alarm.alb_5xx[0].arn
      alb_latency = aws_cloudwatch_metric_alarm.alb_latency[0].arn
      alb_4xx     = aws_cloudwatch_metric_alarm.alb_4xx[0].arn
    } : {},

    local.has_rds ? {
      rds_cpu               = aws_cloudwatch_metric_alarm.rds_cpu[0].arn
      rds_connections       = aws_cloudwatch_metric_alarm.rds_connections[0].arn
      rds_read_latency      = aws_cloudwatch_metric_alarm.rds_read_latency[0].arn
      rds_write_latency     = aws_cloudwatch_metric_alarm.rds_write_latency[0].arn
      rds_replica_lag       = aws_cloudwatch_metric_alarm.rds_replica_lag[0].arn
      rds_volume_bytes_used = aws_cloudwatch_metric_alarm.rds_volume_bytes_used[0].arn
    } : {},

    local.has_redis ? {
      redis_cpu              = aws_cloudwatch_metric_alarm.redis_cpu[0].arn
      redis_evictions        = aws_cloudwatch_metric_alarm.redis_evictions[0].arn
      redis_curr_connections = aws_cloudwatch_metric_alarm.redis_curr_connections[0].arn
      redis_freeable_memory  = aws_cloudwatch_metric_alarm.redis_memory[0].arn
      redis_bytes_used       = aws_cloudwatch_metric_alarm.redis_bytes_used[0].arn
    } : {},

    {
      for k, v in aws_cloudwatch_metric_alarm.sqs_visible :
      "sqs_${k}_visible" => v.arn
    },

    {
      for k, v in aws_cloudwatch_metric_alarm.sqs_oldest_age :
      "sqs_${k}_oldest_age" => v.arn
    },

    local.has_dlq ? {
      dlq_visible    = aws_cloudwatch_metric_alarm.dlq_visible[0].arn
      dlq_oldest_age = aws_cloudwatch_metric_alarm.dlq_oldest_age[0].arn
    } : {},

    local.has_lambda ? {
      lambda_errors                = aws_cloudwatch_metric_alarm.lambda_errors[0].arn
      lambda_throttles             = aws_cloudwatch_metric_alarm.lambda_throttles[0].arn
      lambda_duration              = aws_cloudwatch_metric_alarm.lambda_duration[0].arn
      lambda_concurrent_executions = aws_cloudwatch_metric_alarm.lambda_concurrent_executions[0].arn
    } : {},

    local.has_eks ? {
      eks_pod_restarts = aws_cloudwatch_metric_alarm.eks_pod_restarts[0].arn
      eks_node_cpu     = aws_cloudwatch_metric_alarm.eks_node_cpu[0].arn
      eks_node_memory  = aws_cloudwatch_metric_alarm.eks_node_memory[0].arn
    } : {},

    local.has_cloudfront ? {
      cloudfront_5xx = aws_cloudwatch_metric_alarm.cloudfront_5xx[0].arn
      cloudfront_4xx = aws_cloudwatch_metric_alarm.cloudfront_4xx[0].arn
    } : {},

    local.has_waf ? {
      waf_blocked_requests = aws_cloudwatch_metric_alarm.waf_blocked_requests[0].arn
    } : {}
  )
}