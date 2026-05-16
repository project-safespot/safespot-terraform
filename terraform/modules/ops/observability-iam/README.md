# observability-iam

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.34, < 7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fluentbit_irsa"></a> [fluentbit\_irsa](#module\_fluentbit\_irsa) | ../../../modules/api-service/eks-irsa | n/a |
| <a name="module_grafana_irsa"></a> [grafana\_irsa](#module\_grafana\_irsa) | ../../../modules/api-service/eks-irsa | n/a |
| <a name="module_yace_irsa"></a> [yace\_irsa](#module\_yace\_irsa) | ../../../modules/api-service/eks-irsa | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.fluentbit_cloudwatch_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.grafana_cloudwatch_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.yace_cloudwatch_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_ssm_parameter.grafana_irsa_role_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.yace_irsa_role_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_oidc_provider_arn"></a> [eks\_oidc\_provider\_arn](#input\_eks\_oidc\_provider\_arn) | EKS OIDC Provider ARN.<br/>형식: arn:aws:iam::123456789012:oidc-provider/oidc.eks...<br/>compute 파트 remote state output에서 참조.<br/>IRSA assume role principal에 사용. | `string` | n/a | yes |
| <a name="input_eks_oidc_provider_url"></a> [eks\_oidc\_provider\_url](#input\_eks\_oidc\_provider\_url) | EKS OIDC Provider URL.<br/>형식: https://oidc.eks.ap-northeast-2.amazonaws.com/id/EXAMPLED539D4633E53DE1B716D3041E<br/>compute 파트 remote state output에서 참조.<br/>IRSA assume role condition에 사용. | `string` | n/a | yes |
| <a name="input_enable_fluentbit_irsa"></a> [enable\_fluentbit\_irsa](#input\_enable\_fluentbit\_irsa) | Fluent Bit CloudWatch Logs write용 IRSA Role 생성 여부.<br/>monitoring.md: Application log → Fluent Bit → CloudWatch Logs<br/>Fluent Bit을 배포할 예정이면 true.<br/>TODO: logging chart 설계 확정 후 true로 변경할 것. | `bool` | `false` | no |
| <a name="input_enable_grafana_irsa"></a> [enable\_grafana\_irsa](#input\_enable\_grafana\_irsa) | Grafana CloudWatch datasource용 IRSA Role 생성 여부.<br/>Grafana가 Prometheus만 datasource로 사용하면 false.<br/>Grafana → CloudWatch 직접 연동 시 true로 변경.<br/>TODO: observability chart 설계 확정 후 결정할 것. | `bool` | `false` | no |
| <a name="input_enable_yace_irsa"></a> [enable\_yace\_irsa](#input\_enable\_yace\_irsa) | YACE CloudWatch metric read용 IRSA Role 생성 여부. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |
| <a name="input_fluentbit_namespace"></a> [fluentbit\_namespace](#input\_fluentbit\_namespace) | Fluent Bit이 배포된 Kubernetes namespace.<br/>monitoring.md: Application log → Fluent Bit → CloudWatch Logs<br/>TODO: Fluent Bit Helm chart 배포 시 사용할 namespace와 반드시 일치시킬 것. | `string` | `"logging"` | no |
| <a name="input_fluentbit_service_account_name"></a> [fluentbit\_service\_account\_name](#input\_fluentbit\_service\_account\_name) | Fluent Bit ServiceAccount 이름.<br/>TODO: Fluent Bit Helm chart의<br/>      serviceAccount.name 값과 반드시 일치시킬 것. | `string` | `"fluent-bit"` | no |
| <a name="input_grafana_namespace"></a> [grafana\_namespace](#input\_grafana\_namespace) | Grafana가 배포된 Kubernetes namespace.<br/>TODO: observability Helm chart 배포 시 사용할 namespace와 반드시 일치시킬 것.<br/>      Prometheus와 같은 namespace를 쓰는 경우가 많으므로 확인 필요. | `string` | `"monitoring"` | no |
| <a name="input_grafana_service_account_name"></a> [grafana\_service\_account\_name](#input\_grafana\_service\_account\_name) | Grafana ServiceAccount 이름.<br/>IRSA condition의 sub claim에 사용.<br/>TODO: observability Helm chart의<br/>      grafana.serviceAccount.name 값과 반드시 일치시킬 것. | `string` | `"safespot-grafana"` | no |
| <a name="input_log_group_arns"></a> [log\_group\_arns](#input\_log\_group\_arns) | Fluent Bit이 write 권한을 가져야 할 CloudWatch Log Group ARN 목록.<br/>log-groups 모듈의 all\_log\_group\_arns output에서 참조.<br/>최소 권한 원칙: 전체 와일드카드(*) 대신 실제 Log Group ARN만 지정.<br/>TODO: log-groups 모듈 apply 완료 후<br/>      ops remote state output에서 참조하도록 연결할 것. | `list(string)` | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name. | `string` | n/a | yes |
| <a name="input_yace_namespace"></a> [yace\_namespace](#input\_yace\_namespace) | YACE가 배포될 Kubernetes namespace. | `string` | `"monitoring"` | no |
| <a name="input_yace_service_account_name"></a> [yace\_service\_account\_name](#input\_yace\_service\_account\_name) | YACE ServiceAccount 이름. | `string` | `"safespot-yace"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fluentbit_cloudwatch_write_policy_arn"></a> [fluentbit\_cloudwatch\_write\_policy\_arn](#output\_fluentbit\_cloudwatch\_write\_policy\_arn) | Fluent Bit CloudWatch Logs write 전용 IAM Policy ARN. enable\_fluentbit\_irsa = false 이면 null 반환 |
| <a name="output_fluentbit_irsa_role_arn"></a> [fluentbit\_irsa\_role\_arn](#output\_fluentbit\_irsa\_role\_arn) | Fluent Bit CloudWatch Logs write IRSA Role ARN. enable\_fluentbit\_irsa = false 이면 null 반환 |
| <a name="output_fluentbit_irsa_role_name"></a> [fluentbit\_irsa\_role\_name](#output\_fluentbit\_irsa\_role\_name) | Fluent Bit IRSA Role 이름. enable\_fluentbit\_irsa = false 이면 null 반환 |
| <a name="output_fluentbit_irsa_subject"></a> [fluentbit\_irsa\_subject](#output\_fluentbit\_irsa\_subject) | Kubernetes service account subject used by Fluent Bit IRSA trust policy. |
| <a name="output_grafana_cloudwatch_read_policy_arn"></a> [grafana\_cloudwatch\_read\_policy\_arn](#output\_grafana\_cloudwatch\_read\_policy\_arn) | Grafana CloudWatch datasource IAM Policy ARN. enable\_grafana\_irsa = false 이면 null 반환 |
| <a name="output_grafana_irsa_role_arn"></a> [grafana\_irsa\_role\_arn](#output\_grafana\_irsa\_role\_arn) | IAM role ARN for Grafana CloudWatch datasource IRSA. |
| <a name="output_grafana_irsa_role_name"></a> [grafana\_irsa\_role\_name](#output\_grafana\_irsa\_role\_name) | IAM role name for Grafana CloudWatch datasource IRSA. |
| <a name="output_grafana_irsa_subject"></a> [grafana\_irsa\_subject](#output\_grafana\_irsa\_subject) | Kubernetes service account subject used by Grafana IRSA trust policy. |
| <a name="output_irsa_role_arns"></a> [irsa\_role\_arns](#output\_irsa\_role\_arns) | 생성된 IRSA Role ARN 전체 map. 활성화된 Role만 포함 |
| <a name="output_yace_cloudwatch_read_policy_arn"></a> [yace\_cloudwatch\_read\_policy\_arn](#output\_yace\_cloudwatch\_read\_policy\_arn) | YACE CloudWatch metrics read IAM Policy ARN. enable\_yace\_irsa = false 이면 null 반환 |
| <a name="output_yace_irsa_role_arn"></a> [yace\_irsa\_role\_arn](#output\_yace\_irsa\_role\_arn) | IAM role ARN for YACE IRSA. |
| <a name="output_yace_irsa_role_name"></a> [yace\_irsa\_role\_name](#output\_yace\_irsa\_role\_name) | IAM role name for YACE IRSA. |
| <a name="output_yace_irsa_subject"></a> [yace\_irsa\_subject](#output\_yace\_irsa\_subject) | Kubernetes service account subject used by YACE IRSA trust policy. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
