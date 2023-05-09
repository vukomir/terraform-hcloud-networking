Terraform module which creates networking resources on Hetzner Cloud.

## Usage
```hcl
module "networking" {
  source = "vukomir/networking/hcloud"

  name             = "xyz-production"
  cidr             = "10.0.0.0/16"
  public_subnets   = ["10.0.0.0/24"]
  private_subnets  = ["10.0.1.0/24"]
  database_subnets = ["10.0.10.0/24"]

  natgateway_create      = true
  natgateway_enable_ipv6 = true
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.38.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | >= 1.38.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_network.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network) | resource |
| [hcloud_network_route.default](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_route) | resource |
| [hcloud_network_subnet.database](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.private](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.public](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_primary_ip.nat_ip4](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/primary_ip) | resource |
| [hcloud_primary_ip.nat_ipv6](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/primary_ip) | resource |
| [hcloud_server.nat](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | (Optional) The IPv4 CIDR block for the network. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id` | `string` | `"0.0.0.0/0"` | no |
| <a name="input_create_networking"></a> [create\_networking](#input\_create\_networking) | Controls if networking should be created. | `bool` | `true` | no |
| <a name="input_database_subnets"></a> [database\_subnets](#input\_database\_subnets) | A list of public subnets inside the VPC | `list(string)` | `[]` | no |
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | (Optional, string) The datacenter name to create the server in. nbg1-dc3, fsn1-dc14, hel1-dc2, ash-dc1 or hil-dc1 | `string` | `"nbg1-dc3"` | no |
| <a name="input_delete_protection"></a> [delete\_protection](#input\_delete\_protection) | (Optional, bool) Enable or disable delete protection. Default is false. | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to add to all resources | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on all the resources as identifier | `string` | `""` | no |
| <a name="input_natgateway_create"></a> [natgateway\_create](#input\_natgateway\_create) | enable nat gateway creation | `bool` | `true` | no |
| <a name="input_natgateway_enable_ipv6"></a> [natgateway\_enable\_ipv6](#input\_natgateway\_enable\_ipv6) | enable ipv6 nat gateway | `bool` | `false` | no |
| <a name="input_natgateway_image"></a> [natgateway\_image](#input\_natgateway\_image) | NatGateway image | `string` | `"ubuntu-22.04"` | no |
| <a name="input_natgateway_labels"></a> [natgateway\_labels](#input\_natgateway\_labels) | A map of labels to add to all resources | `map(string)` | `{}` | no |
| <a name="input_natgateway_private_ip"></a> [natgateway\_private\_ip](#input\_natgateway\_private\_ip) | private IP address of NatGateway, usually first IP address from public subnets | `string` | `"10.0.0.2"` | no |
| <a name="input_natgateway_server_type"></a> [natgateway\_server\_type](#input\_natgateway\_server\_type) | NatGateway server type | `string` | `"cx11"` | no |
| <a name="input_natgateway_ssh_key"></a> [natgateway\_ssh\_key](#input\_natgateway\_ssh\_key) | (Optional, list) SSH key IDs which should be injected into the server at creation time | `list(number)` | `[]` | no |
| <a name="input_network_zone"></a> [network\_zone](#input\_network\_zone) | (Required, string) Name of network zone. Must be 'eu-central', 'us-east' or 'us-west' | `string` | `"eu-central"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of public subnets inside the VPC | `list(string)` | `[]` | no |
| <a name="input_public_subnet_suffix"></a> [public\_subnet\_suffix](#input\_public\_subnet\_suffix) | Suffix to append to public subnets name | `string` | `"public"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets inside the VPC | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnets_ids"></a> [database\_subnets\_ids](#output\_database\_subnets\_ids) | List of IDs of database subnets |
| <a name="output_nat_public_ipv4"></a> [nat\_public\_ipv4](#output\_nat\_public\_ipv4) | Nat Gateway public ipv4 IP |
| <a name="output_nat_public_ipv6"></a> [nat\_public\_ipv6](#output\_nat\_public\_ipv6) | Nat Gateway public ipv6 IP |
| <a name="output_network_cidr_block"></a> [network\_cidr\_block](#output\_network\_cidr\_block) | The CIDR block of the network |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | The ID of the network |
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | List of IDs of private subnets |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | List of IDs of public subnets |
<!-- END_TF_DOCS -->

## Copyright

Copyright © 2023 [Vucomir Ianculov](https://ianculov.ro)



## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```

### Contributors

![GitHub Contributors Image](https://contrib.rocks/image?repo=vukomir/terraform-hetzner-networking)

