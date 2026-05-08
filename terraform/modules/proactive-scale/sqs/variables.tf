variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

# consumer 처리 시간(HPA GET + PATCH ≈ 수 초) 대비 충분한 여유
variable "visibility_timeout_seconds" {
  description = "SQS visibility timeout in seconds"
  type        = number
  default     = 60
}

# scale 이벤트는 재시도 가능하므로 retention을 충분히 확보
variable "message_retention_seconds" {
  description = "SQS message retention period in seconds"
  type        = number
  default     = 345600
}

variable "dlq_message_retention_seconds" {
  description = "DLQ message retention period in seconds"
  type        = number
  default     = 1209600
}

# invalid payload(PoisonMessage)는 maxReceiveCount 초과 시 DLQ로 이동
variable "max_receive_count" {
  description = "Number of receives before moving to DLQ"
  type        = number
  default     = 3
}

# long polling: K8s deployment이 직접 poll하므로 20초 설정
variable "receive_wait_time_seconds" {
  description = "SQS long polling wait time in seconds"
  type        = number
  default     = 20
}

variable "delay_seconds" {
  description = "SQS message delivery delay in seconds"
  type        = number
  default     = 0
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}
