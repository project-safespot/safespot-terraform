# ── 공용 DLQ ─────────────────────────────────────────────────────
# ⚠️ 확인 필요: 공용 DLQ는 어느 큐에서 실패한 메시지인지 구분이 어렵다.
# 운영 초기에는 단순화를 위해 공용으로 두되,
# 큐별 DLQ 분리가 필요하면 각 큐에 전용 DLQ를 추가해야 한다.
resource "aws_sqs_queue" "dlq" {
  name                      = "${var.project}-${var.environment}-async-worker-sqs-dlq"
  message_retention_seconds = var.dlq_message_retention_seconds

  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-async-worker-sqs-dlq"
  })
}

# ── Cache Refresh Queue ───────────────────────────────────────────
resource "aws_sqs_queue" "cache_refresh" {
  name                       = "${var.project}-${var.environment}-async-worker-sqs-cache-refresh"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    # transient 장애(Redis, DB, network 등)로 인한 일시적 실패를 고려해
    # 일정 횟수 재시도 후 DLQ로 이동
    # consumer 처리 특성 및 장애 패턴에 따라 값 조정 필요
    maxReceiveCount = var.max_receive_count
  })

  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-async-worker-sqs-cache-refresh"
  })
}

# ── Readmodel Queue ───────────────────────────────────────────────
resource "aws_sqs_queue" "readmodel" {
  name                       = "${var.project}-${var.environment}-async-worker-sqs-readmodel"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count
  })

  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-async-worker-sqs-readmodel"
  })
}

# ── Env Cache Queue ───────────────────────────────────────────────
resource "aws_sqs_queue" "env_cache" {
  name                       = "${var.project}-${var.environment}-async-worker-sqs-env-cache"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count
  })

  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-async-worker-sqs-env-cache"
  })
}
