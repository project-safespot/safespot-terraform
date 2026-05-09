aws_region = "ap-northeast-2"
project    = "safespot"
env        = "dev"

remote_state_bucket = "safespot-terraform-state"
data_state_key      = "environments/dev/data/terraform.tfstate"
ops_state_key       = "environments/dev/ops/terraform.tfstate"

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

  # render-dev-values.sh → safespot.aws.alb.loadBalancerDimension
  # ops CloudWatch alarm dimension과 동일 값; ALB 재생성 시 함께 업데이트
  "front-edge/alb-arn-suffix" = {
    value       = "app/k8s-safespotdevapi-00c466700d/e7b7aa08dfee8e6e"
    type        = "String"
    description = "ALB ARN suffix for CloudWatch alarm dimension"
  }
}
