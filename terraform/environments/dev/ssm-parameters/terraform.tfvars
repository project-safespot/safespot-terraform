aws_region = "ap-northeast-2"
project    = "safespot"
env        = "dev"

ssm_parameters = {
  "common/aws-region" = {
    value       = "ap-northeast-2"
    type        = "String"
    description = "AWS region"
  }

  "common/spring-profile" = {
    value       = "dev"
    type        = "String"
    description = "Spring profile"
  }

  "common/redis-port" = {
    value       = "6379"
    type        = "String"
    description = "Redis port"
  }
}

common_tags = {
  Project     = "SafeSpot"
  Environment = "dev"
  ManagedBy   = "Terraform"
  Area        = "ssm-parameters"
}
