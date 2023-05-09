variable "create_networking" {
  description = "Controls if networking should be created."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "(Optional) The IPv4 CIDR block for the network. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "0.0.0.0/0"
}

variable "network_zone" {
  description = ""
  type        = string
  validation {
    condition     = contains(["eu-central", "us-east", "us-west"], var.network_zone)
    error_message = "network zone must be 'eu-central', 'us-east' or 'us-west'."
  }
  default = "eu-central"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "database_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "delete_protection" {
  description = "(Optional, bool) Enable or disable delete protection. Default is false."
  type        = bool
  default     = false
}

variable "labels" {
  description = "A map of labels to add to all resources"
  type        = map(string)
  default     = {}
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "public"
}

variable "datacenter" {
  description = "(Optional, string) The datacenter name to create the server in. nbg1-dc3, fsn1-dc14, hel1-dc2, ash-dc1 or hil-dc1"
  type        = string
  validation {
    condition     = contains(["nbg1-dc3", "fsn1-dc14", "hel1-dc2", "ash-dc1", "hil-dc1"], var.datacenter)
    error_message = "datacenter must be nbg1-dc3, fsn1-dc14, hel1-dc2, ash-dc1 or hil-dc1."
  }
  default = "nbg1-dc3"
}

#
# NatGateway Configuration
#
variable "natgateway_create" {
  description = "enable nat gateway creation"
  type        = bool
  default     = true
}

variable "natgateway_ssh_key" {
  description = "(Optional, list) SSH key IDs which should be injected into the server at creation time"
  type        = list(number)
  default     = []
}

variable "natgateway_enable_ipv6" {
  description = "enable ipv6 nat gateway"
  type        = bool
  default     = false
}

variable "natgateway_server_type" {
  description = "NatGateway server type"
  type        = string
  default     = "cx11"
}

variable "natgateway_image" {
  description = "NatGateway image"
  type        = string
  default     = "ubuntu-22.04"
}

variable "natgateway_private_ip" {
  description = "private IP address of NatGateway, usually first IP address from public subnets"
  type        = string
  default     = "10.0.0.2"
}

variable "natgateway_labels" {
  description = "A map of labels to add to all resources"
  type        = map(string)
  default     = {}
}
