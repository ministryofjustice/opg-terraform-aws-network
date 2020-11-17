# opg-terrafrom-aws-network
Standard OPG AWS Network Module: Managed by opg-org-infra &amp; Terraform

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr | n/a | `string` | `"0.0.0.0/0"` | no |
| default\_security\_group\_egress | n/a | `list(map(string))` | `null` | no |
| default\_security\_group\_ingress | n/a | `list(map(string))` | `null` | no |
| default\_security\_group\_name | n/a | `string` | `"default"` | no |
| dhcp\_options\_domain\_name | n/a | `string` | `""` | no |
| dhcp\_options\_domain\_name\_servers | n/a | `list(string)` | <pre>[<br>  "AmazonProvidedDNS"<br>]</pre> | no |
| enable\_dns\_hostnames | n/a | `bool` | `false` | no |
| enable\_dns\_support | n/a | `bool` | `true` | no |
| flow\_log\_cloudwatch\_log\_group\_kms\_key\_id | n/a | `string` | `null` | no |
| flow\_log\_cloudwatch\_log\_group\_retention\_in\_days | Number of days you want to retain log events. | `number` | `null` | no |
| flow\_log\_log\_format | n/a | `string` | `null` | no |
| flow\_log\_traffic\_type | The type of traffic to log. Values: ACCEPT, REJECT, ALL. | `string` | `"ALL"` | no |
| instance\_tenancy | n/a | `string` | `"default"` | no |
| map\_public\_ip\_on\_launch | n/a | `bool` | `false` | no |
| public\_subnet\_assign\_ipv6\_address\_on\_creation | n/a | `bool` | `false` | no |
| tags | n/a | `map(string)` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
