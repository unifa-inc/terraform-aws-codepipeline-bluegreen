<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codepipeline.ecs_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_role.codepipeline_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ecs_codepipeline_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.add_role_codepipeline_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codepipeline_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_principal_role"></a> [add\_principal\_role](#input\_add\_principal\_role) | Additional principal to allow access | `string` | `""` | no |
| <a name="input_artifact_store_bucket"></a> [artifact\_store\_bucket](#input\_artifact\_store\_bucket) | Name of the s3 bucket to store the artifact | `string` | `""` | no |
| <a name="input_category"></a> [category](#input\_category) | Category name corresponding to provider | `map` | <pre>{<br>  "CodeDeployToECS": "Deploy",<br>  "ECR": "Source",<br>  "ECS": "Deploy",<br>  "S3": "Source",<br>  "StepFunctions": "Invoke"<br>}</pre> | no |
| <a name="input_deploy_action_run_1"></a> [deploy\_action\_run\_1](#input\_deploy\_action\_run\_1) | Action 1 to be run at the deploy | `list` | `[]` | no |
| <a name="input_deploy_action_run_2"></a> [deploy\_action\_run\_2](#input\_deploy\_action\_run\_2) | Action 2 to be run at the deploy | `list` | `[]` | no |
| <a name="input_deploy_action_run_3"></a> [deploy\_action\_run\_3](#input\_deploy\_action\_run\_3) | Action 3 to be run at the deploy | `list` | `[]` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Service name | `string` | n/a | yes |
| <a name="input_service_suffix"></a> [service\_suffix](#input\_service\_suffix) | Service suffix | `string` | `""` | no |
| <a name="input_source_action_run_1"></a> [source\_action\_run\_1](#input\_source\_action\_run\_1) | Action 1 to be run at the source | `list` | `[]` | no |
| <a name="input_source_action_run_2"></a> [source\_action\_run\_2](#input\_source\_action\_run\_2) | Action 2 to be run at the source | `list` | `[]` | no |
| <a name="input_source_action_run_3"></a> [source\_action\_run\_3](#input\_source\_action\_run\_3) | Action 3 to be run at the source | `list` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `any` | `null` | no |
| <a name="input_trigger_ecr_repository_name"></a> [trigger\_ecr\_repository\_name](#input\_trigger\_ecr\_repository\_name) | ECR repository name that trigger codepipeline startup | `any` | `null` | no |
| <a name="input_trigger_tag"></a> [trigger\_tag](#input\_trigger\_tag) | Tags that trigger codepipeline startup | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codepipeline_arn"></a> [codepipeline\_arn](#output\_codepipeline\_arn) | The ARN assigned by AWS to this codepipeline |
<!-- END_TF_DOCS -->