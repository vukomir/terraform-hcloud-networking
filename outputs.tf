output "network_id" {
  description = "The ID of the network"
  value       = try(hcloud_network.this[0].id, null)
}

output "network_cidr_block" {
  description = "The CIDR block of the network"
  value       = try(hcloud_network.this[0].ip_range, null)
}

output "public_subnets_ids" {
  description = "List of IDs of public subnets"
  value       = hcloud_network_subnet.public[*].id
}

output "private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = hcloud_network_subnet.private[*].id
}

output "database_subnets_ids" {
  description = "List of IDs of database subnets"
  value       = hcloud_network_subnet.database[*].id
}

output "nat_public_ipv4" {
  description = "Nat Gateway public ipv4 IP"
  value       = local.create_natgateway ? hcloud_primary_ip.nat_ip4[0].ip_address : null
}

output "nat_public_ipv6" {
  description = "Nat Gateway public ipv6 IP"
  value       = local.create_natgateway_ipv6 ? hcloud_primary_ip.nat_ipv6[0].ip_address : null
}
