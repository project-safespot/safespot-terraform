# ── Cache Refresh Queue ───────────────────────────────────────────

output "cache_refresh_queue_name" {
  description = "Cache refresh queue name."
  value       = aws_sqs_queue.cache_refresh.name
}

output "cache_refresh_queue_arn" {
  description = "Cache refresh queue ARN."
  value       = aws_sqs_queue.cache_refresh.arn
}

output "cache_refresh_queue_url" {
  description = "Cache refresh queue URL."
  value       = aws_sqs_queue.cache_refresh.url
}

# ── Readmodel Queue ───────────────────────────────────────────────

output "readmodel_queue_name" {
  description = "Readmodel queue name."
  value       = aws_sqs_queue.readmodel.name
}

output "readmodel_queue_arn" {
  description = "Readmodel queue ARN."
  value       = aws_sqs_queue.readmodel.arn
}

output "readmodel_queue_url" {
  description = "Readmodel queue URL."
  value       = aws_sqs_queue.readmodel.url
}

# ── Env Cache Queue ───────────────────────────────────────────────

output "env_cache_queue_name" {
  description = "Environment cache queue name."
  value       = aws_sqs_queue.env_cache.name
}

output "env_cache_queue_arn" {
  description = "Environment cache queue ARN."
  value       = aws_sqs_queue.env_cache.arn
}

output "env_cache_queue_url" {
  description = "Environment cache queue URL."
  value       = aws_sqs_queue.env_cache.url
}

# ── 공용 DLQ ─────────────────────────────────────────────────────

output "dlq_name" {
  description = "Shared dead-letter queue name."
  value       = aws_sqs_queue.dlq.name
}

output "dlq_arn" {
  description = "Shared dead-letter queue ARN."
  value       = aws_sqs_queue.dlq.arn
}

output "dlq_url" {
  description = "Shared dead-letter queue URL."
  value       = aws_sqs_queue.dlq.url
}
