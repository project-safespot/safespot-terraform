output "queue_name" {
  description = "Proactive scale queue name."
  value       = aws_sqs_queue.proactive_scale.name
}

output "queue_arn" {
  description = "Proactive scale queue ARN."
  value       = aws_sqs_queue.proactive_scale.arn
}

output "queue_url" {
  description = "Proactive scale queue URL."
  value       = aws_sqs_queue.proactive_scale.url
}

output "dlq_name" {
  description = "Proactive scale dead-letter queue name."
  value       = aws_sqs_queue.proactive_scale_dlq.name
}

output "dlq_arn" {
  description = "Proactive scale dead-letter queue ARN."
  value       = aws_sqs_queue.proactive_scale_dlq.arn
}

output "dlq_url" {
  description = "Proactive scale dead-letter queue URL."
  value       = aws_sqs_queue.proactive_scale_dlq.url
}
