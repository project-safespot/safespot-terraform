aws_region          = "ap-northeast-2"
environment         = "dev"
project             = "safespot"
remote_state_bucket = "safespot-terraform-state"
remote_state_region = "ap-northeast-2"

services = [
  "api-core",
  "api-public-read",
  "external-ingestion",
  "async-worker",
]

log_retention_days = 30

# TODO: 아래 네 값을 실제 인프라 값으로 교체한 후 apply
alert_email    = "201sohyun@naver.com"
alb_arn_suffix = "app/k8s-safespotdevapi-00c466700d/e7b7aa08dfee8e6e"
aws_account_id = "123456789012"

enable_observability_iam = false
# 아래 세 플래그는 실제 ServiceAccount annotation 적용(Helm values/ArgoCD app) 확정 후 활성화
enable_fluentbit_irsa  = false
enable_prometheus_irsa = false
enable_grafana_irsa    = false
