# ── api-service 연동 output (변경 금지) ──────────────────────────
# cache_refresh 큐를 대표 event queue로 매핑한다.
# api-service IRSA의 sqs:SendMessage 권한 대상은 cache_refresh 큐 ARN 기준.
# readmodel / env_cache 큐에도 publish가 필요하면 api-service에서 별도 ARN output을 참조해야 한다.

output "event_queue_name" {
  description = "Main event queue name (cache_refresh queue)."
  value       = module.sqs.cache_refresh_queue_name
}

output "event_queue_arn" {
  description = "Main event queue ARN (cache_refresh queue)."
  value       = module.sqs.cache_refresh_queue_arn
}

output "event_queue_url" {
  description = "Main event queue URL (cache_refresh queue)."
  value       = module.sqs.cache_refresh_queue_url
}

output "event_dlq_name" {
  description = "Shared dead-letter queue name."
  value       = module.sqs.dlq_name
}

output "event_dlq_arn" {
  description = "Shared dead-letter queue ARN."
  value       = module.sqs.dlq_arn
}

output "event_dlq_url" {
  description = "Shared dead-letter queue URL."
  value       = module.sqs.dlq_url
}

# ── ops monitoring output ─────────────────────────────────────────

output "sqs_queue_name_cache_refresh" {
  description = "SQS queue name for cache refresh events."
  value       = module.sqs.cache_refresh_queue_name
}

output "sqs_queue_name_readmodel" {
  description = "SQS queue name for read model refresh events."
  value       = module.sqs.readmodel_queue_name
}

output "sqs_queue_name_env_cache" {
  description = "SQS queue name for environment cache refresh events."
  value       = module.sqs.env_cache_queue_name
}

output "sqs_dlq_name" {
  description = "SQS dead-letter queue name for async-worker events."
  value       = module.sqs.dlq_name
}

output "lambda_function_name" {
  description = "Async-worker Lambda function name for ops monitoring. Null until Lambda resource is managed by Terraform."
  value       = var.lambda_function_name
}

output "lambda_reserved_concurrent_executions" {
  description = "Async-worker Lambda reserved concurrency for ops monitoring. Null until Lambda resource is managed by Terraform."
  value       = var.lambda_reserved_concurrent_executions
}
