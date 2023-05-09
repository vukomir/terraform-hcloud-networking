resource "hcloud_network" "this" {
  count = local.create_networking ? 1 : 0

  name              = var.name
  ip_range          = var.cidr
  delete_protection = var.delete_protection

  labels = merge({
    "Name" : var.name,
    },
    var.labels,
  )
}

#
# Subnets
#

resource "hcloud_network_subnet" "public" {
  count = local.create_networking && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  network_id   = local.network_id
  type         = "cloud"
  network_zone = var.network_zone
  ip_range     = element(concat(var.public_subnets, [""]), count.index)
}

resource "hcloud_network_subnet" "private" {
  count = local.create_networking && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  network_id   = local.network_id
  type         = "cloud"
  network_zone = var.network_zone
  ip_range     = element(concat(var.private_subnets, [""]), count.index)
}

resource "hcloud_network_subnet" "database" {
  count = local.create_networking && length(var.database_subnets) > 0 ? length(var.database_subnets) : 0

  network_id   = local.network_id
  type         = "cloud"
  network_zone = var.network_zone
  ip_range     = element(concat(var.database_subnets, [""]), count.index)
}

#
# default route configuration
#

resource "hcloud_network_route" "default" {
  count = local.create_natgateway ? 1 : 0

  network_id  = hcloud_network.this[0].id
  destination = "0.0.0.0/0"
  gateway     = var.natgateway_private_ip
}
