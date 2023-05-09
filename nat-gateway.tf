resource "hcloud_primary_ip" "nat_ip4" {
  count = local.create_natgateway ? 1 : 0

  name          = "nat-gateway-ipv4"
  datacenter    = var.datacenter
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = false

  labels = merge({
    "Name" : var.name,
    "Type" : "ipv4",
    },
    var.labels,
    var.natgateway_labels
  )
}

resource "hcloud_primary_ip" "nat_ipv6" {
  count = local.create_natgateway_ipv6 ? 1 : 0

  name          = "nat-gateway-ipv6"
  datacenter    = var.datacenter
  type          = "ipv6"
  assignee_type = "server"
  auto_delete   = false

  labels = merge({
    "Name" : var.name,
    "Type" : "ipv6",
    },
    var.labels,
    var.natgateway_labels
  )
}

resource "hcloud_server" "nat" {
  count = local.create_natgateway ? 1 : 0

  name        = "nat-gateway"
  server_type = var.natgateway_server_type
  image       = var.natgateway_image
  location    = split("-", var.datacenter)[0]
  ssh_keys    = var.natgateway_ssh_key
  user_data   = file("${path.module}/scripts/nat-cloudinit.yaml")

  network {
    network_id = hcloud_network.this[0].id
    ip         = var.natgateway_private_ip
  }

  public_net {
    ipv4         = hcloud_primary_ip.nat_ip4[0].id
    ipv6_enabled = local.create_natgateway_ipv6
    ipv6         = local.create_natgateway_ipv6 ? hcloud_primary_ip.nat_ipv6[0].id : null

  }

  labels = merge({
    "Name" : var.name,
    "Type" : "NatGateway",
    },
    var.labels,
    var.natgateway_labels
  )

  lifecycle {
    ignore_changes = [
      user_data,
      ssh_keys,
      image
    ]
  }

  depends_on = [
    hcloud_network_subnet.public
  ]

}
