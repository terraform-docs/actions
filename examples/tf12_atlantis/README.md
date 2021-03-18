# Test tf12 Atlantis

## Input

```yaml
- name: Should generate README.md for tf12_atlantis
  uses: ./
  with:
    atlantis-file: atlantis.yaml
    output-file: README.md
    args: --hide providers
    indention: 3
```

## Verify

- Should inject below Usage in README.md
- Should not show providers section

## Usage

<!--- BEGIN_TF_DOCS --->
### Requirements

| Name | Version |
|------|---------|
| aws | ~> 2.20.0 |
| consul | >= 2.4.0 |

### Providers

| Name | Version |
|------|---------|
| aws | ~> 2.20.0 |
| consul | >= 2.4.0 |

### Modules

No Modules.

### Resources

| Name |
|------|
| [aws_acm_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) |
| [consul_key](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/data-sources/key) |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| extra\_environment | List of additional environment variables | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| extra\_tags | Additional tags | `map(string)` | `{}` | no |
| instance\_count | Number of instances to create | `number` | `1` | no |
| instance\_name | Instance name prefix | `string` | `"test-"` | no |
| subnet\_ids | A list of subnet ids to use | `list(string)` | n/a | yes |
| vpc\_id | The id of the vpc | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| vpc\_id | The Id of the VPC |
<!--- END_TF_DOCS --->
