<!-- BEGIN_TF_DOCS -->
### Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (< 2.2.0)

- <a name="provider_consul"></a> [consul](#provider\_consul) (>= 1.0.0)

### Modules

No modules.

### Resources

The following resources are used by this module:

- [aws_acm_certificate.test-cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) (data source)
- [consul_key.test](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/data-sources/key) (data source)

### Inputs

The following input variables are supported:

#### <a name="input_extra_environment"></a> [extra\_environment](#input\_extra\_environment)

Description: List of additional environment variables

Type: `list`

Default: `[]`

#### <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags)

Description: Additional tags

Type: `map`

Default: `{}`

#### <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count)

Description: Number of instances to create

Type: `string`

Default: `"1"`

#### <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name)

Description: Instance name prefix

Type: `string`

Default: `"test-"`

#### <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids)

Description: A list of subnet ids to use

Type: `list`

Default: n/a

#### <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id)

Description: The id of the vpc

Type: `string`

Default: n/a

### Outputs

The following outputs are exported:

#### <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id)

Description: The Id of the VPC
<!-- END_TF_DOCS -->
