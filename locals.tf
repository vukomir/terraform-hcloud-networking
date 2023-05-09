locals {
  create_networking      = var.create_networking
  create_natgateway      = var.create_networking && var.natgateway_create
  create_natgateway_ipv6 = var.create_networking && var.natgateway_create && var.natgateway_enable_ipv6
  network_id             = try(hcloud_network.this[0].id, "")
}
