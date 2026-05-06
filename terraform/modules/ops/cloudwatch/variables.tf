variable "environment" {
  description = "Environment name"
  type        = string
}

variable "sns_topic_arn" {
  type = string
}

# [삭제] alb_arn_suffix 제거

variable "alb_5xx_threshold" {
  type    = number
  default = 5
}

variable "alb_4xx_threshold" {
  type    = number
  default = 100
}

variable "alb_latency_threshold" {
  type    = number
  default = 2
}

variable "rds_cluster_identifier" {
  type    = string
  default = ""
}

variable "rds_cpu_threshold" {
  type    = number
  default = 80
}

variable "rds_connections_threshold" {
  type    = number
  default = 200
}

variable "rds_read_latency_threshold" {
  type    = number
  default = 0.1
}

variable "rds_write_latency_threshold" {
  type    = number
  default = 0.1
}

variable "rds_deadlock_threshold" {
  type    = number
  default = 0
}

variable "rds_free_storage_threshold_bytes" {
  type    = number
  default = 10737418240
}

variable "redis_cluster_id" {
  type    = string
  default = ""
}

variable "redis_cpu_threshold" {
  type    = number
  default = 80
}

variable "redis_evictions_threshold" {
  type    = number
  default = 0
}

variable "redis_curr_connections_threshold" {
  type    = number
  default = 500
}

variable "redis_memory_threshold" {
  type    = number
  default = 80
}

variable "sqs_queue_names" {
  type = object({
    cache_refresh = string
    readmodel     = string
    env_cache     = string
    dlq           = string
  })

  default = {
    cache_refresh = ""
    readmodel     = ""
    env_cache     = ""
    dlq           = ""
  }
}

variable "sqs_age_threshold_seconds" {
  type    = number
  default = 300
}

variable "dlq_visible_threshold" {
  type    = number
  default = 0
}

variable "dlq_age_threshold_seconds" {
  type    = number
  default = 3600
}

variable "lambda_function_name" {
  type    = string
  default = ""
}

variable "lambda_error_threshold" {
  type    = number
  default = 0
}

variable "lambda_throttle_threshold" {
  type    = number
  default = 0
}

variable "lambda_duration_threshold_ms" {
  type    = number
  default = 10000
}

variable "lambda_concurrent_executions_threshold" {
  type    = number
  default = 80
}

variable "eks_cluster_name" {
  type    = string
  default = ""
}

variable "eks_pod_restart_threshold" {
  type    = number
  default = 3
}

variable "eks_node_cpu_threshold" {
  type    = number
  default = 80
}

variable "eks_node_memory_threshold" {
  type    = number
  default = 80
}

variable "cloudfront_distribution_id" {
  type    = string
  default = ""
}

variable "waf_acl_name" {
  type    = string
  default = ""
}

variable "cloudfront_5xx_threshold" {
  type    = number
  default = 1
}

variable "cloudfront_4xx_threshold" {
  type    = number
  default = 5
}

variable "waf_blocked_threshold" {
  type    = number
  default = 100
}

variable "rds_replica_lag_threshold_ms" {
  description = "Aurora 복제 지연 임계값(ms)"
  type        = number
  default     = 100
}

variable "rds_volume_bytes_threshold" {
  description = "Aurora VolumeBytesUsed 임계값(bytes)"
  type        = number
  default     = 100000000000
}

variable "redis_freeable_memory_threshold_bytes" {
  description = "ElastiCache FreeableMemory 최소 임계값(bytes)"
  type        = number
  default     = 100000000
}

variable "redis_bytes_used_threshold_bytes" {
  description = "ElastiCache BytesUsedForCache 최대 임계값(bytes)"
  type        = number
  default     = 3000000000
}
variable "sqs_visible_threshold" {
  description = "SQS 대기 메시지 수 임계값"
  type        = number
  default     = 100
}

variable "sqs_oldest_age_threshold" {
  description = "SQS 가장 오래된 메시지 대기 시간 임계값 (초)"
  type        = number
  default     = 300
}
