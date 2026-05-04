variable "aws_region" {
  type    = string
  default = "ap-northeast-2"
}

variable "env" {
  type    = string
  default = "dev"

  validation {
    condition     = contains(["dev", "stg", "prod"], var.env)
    error_message = "env는 dev, stg, prod 중 하나여야 합니다."
  }
}

variable "alert_email" {
  type = string
}

variable "slack_webhook_secret_name" {
  type    = string
  default = ""
}

variable "additional_email_subscriptions" {
  type    = list(string)
  default = []
}

variable "enable_slack_secret" {
  type    = bool
  default = true
}

variable "slack_webhook_recovery_window_days" {
  type    = number
  default = 7
}

variable "alb_5xx_threshold" {
  type    = number
  default = 5
}

variable "alb_4xx_threshold" {
  type    = number
  default = 100
}

variable "alb_latency_threshold_seconds" {
  type    = number
  default = 2
}

variable "rds_cpu_threshold" {
  type    = number
  default = 80
}

variable "rds_connections_threshold" {
  type    = number
  default = 200
}

variable "rds_free_storage_threshold_bytes" {
  type    = number
  default = 10737418240
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

variable "sqs_visible_threshold" {
  type    = number
  default = 100
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

variable "lambda_error_threshold" {
  type    = number
  default = 0
}

variable "lambda_throttle_threshold" {
  type    = number
  default = 0
}

variable "lambda_duration_p99_threshold_ms" {
  type    = number
  default = 10000
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

variable "image_tag_mutability" {
  type    = string
  default = "IMMUTABLE"
}

variable "scan_on_push" {
  type    = bool
  default = true
}

variable "max_image_count" {
  type    = number
  default = 20
}

variable "untagged_expiry_days" {
  type    = number
  default = 2
}

variable "lambda_retention_days" {
  type    = number
  default = 60
}

variable "eks_control_plane_retention_days" {
  type    = number
  default = 90
}

variable "eks_log_types" {
  type    = list(string)
  default = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "enable_alb_log_group" {
  type    = bool
  default = false
}

variable "kms_key_arn" {
  type    = string
  default = ""
}

variable "enable_observability_iam" {
  type    = bool
  default = false
}

variable "enable_grafana_irsa" {
  type    = bool
  default = false
}

variable "enable_prometheus_irsa" {
  type    = bool
  default = false
}

variable "enable_fluentbit_irsa" {
  type    = bool
  default = false
}

variable "prometheus_k8s_namespace" {
  type    = string
  default = "monitoring"
}

variable "prometheus_service_account_name" {
  type    = string
  default = "prometheus"
}

variable "grafana_namespace" {
  type    = string
  default = "monitoring"
}

variable "grafana_service_account_name" {
  type    = string
  default = "grafana"
}

variable "fluentbit_namespace" {
  type    = string
  default = "logging"
}

variable "fluentbit_service_account_name" {
  type    = string
  default = "fluent-bit"
}

variable "cloudfront_distribution_id" {
  type    = string
  default = ""
}

variable "waf_acl_name" {
  description = "WAF Web ACL name. CloudWatch WAFV2 metric dimension WebACL에 사용"
  type        = string
  default     = ""
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