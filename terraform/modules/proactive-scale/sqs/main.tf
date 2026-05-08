# ── Proactive Scale DLQ ───────────────────────────────────────────
# PoisonMessage(invalid eventType/level/payload) 수신 시 DLQ로 이동
resource "aws_sqs_queue" "proactive_scale_dlq" {
  name                      = "${var.project}-${var.environment}-proactive-scale-dlq"
  message_retention_seconds = var.dlq_message_retention_seconds

  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-proactive-scale-dlq"
  })
}

# ── Proactive Scale Queue ─────────────────────────────────────────
# Producer: external-ingestion (ProactiveScaleRequested 이벤트)
# Consumer: proactive-scale-controller K8s Deployment
resource "aws_sqs_queue" "proactive_scale" {
  name                       = "${var.project}-${var.environment}-proactive-scale-queue"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  delay_seconds              = var.delay_seconds

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.proactive_scale_dlq.arn
    maxReceiveCount     = var.max_receive_count
  })

  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-proactive-scale-queue"
  })
}
