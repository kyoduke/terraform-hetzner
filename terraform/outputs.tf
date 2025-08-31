output "server_public_ipv4" {
  value = var.ipv4 ? hcloud_primary_ip.primary_ipv4[0].ip_address : null
  description = "Public IPv4"
}

output "server_public_ipv6" {
  value = var.ipv6 ? hcloud_primary_ip.primary_ipv6[0].ip_address : null
  description = "Public IPv6"
}