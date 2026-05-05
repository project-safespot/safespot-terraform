variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "visibility_timeout_seconds" {
  description = "SQS visibility timeout in seconds"
  type        = number
  default     = 180
}

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

variable "max_receive_count" {
  description = "Number of receives before moving to DLQ"
  type        = number
  default     = 5
}

variable "lambda_function_name" {
  description = "Async-worker Lambda function name. Placeholder until Lambda Terraform resource is managed here."
  type        = string
  default     = null
}

variable "lambda_reserved_concurrent_executions" {
  description = "Reserved concurrency for async-worker Lambda. Placeholder until Lambda Terraform resource is managed here."
  type        = number
  default     = null
}
