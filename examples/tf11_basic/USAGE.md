<!-- BEGIN_TF_DOCS -->
# Test tf11 basic

## Verify

Should use the template defined instead of the default
Should inject the table under usage

# Usage

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 2.2.0 |
| <a name="requirement_consul"></a> [consul](#requirement\_consul) | >= 1.0.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | < 2.2.0 |
| <a name="provider_consul"></a> [consul](#provider\_consul) | >= 1.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.test-cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [consul_key.test](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/data-sources/key) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_extra_environment"></a> [extra\_environment](#input\_extra\_environment) | List of additional environment variables | `list` | `[]` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Additional tags | `map` | `{}` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances to create | `string` | `"1"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Instance name prefix | `string` | `"test-"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet ids to use | `list` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of the vpc | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The Id of the VPC |
<!-- END_TF_DOCS -->
