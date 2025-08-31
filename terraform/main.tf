resource "hcloud_primary_ip" "primary_ipv4" {
  count = var.ipv4 ? 1 : 0
  name = "server-1-primary-ipv4"
  type = "ipv4"
  datacenter = "hel1-dc2"
  assignee_type = "server"
  auto_delete = true
  
  labels = {
    "managedBy" : "Terraform"
  }
}

resource "hcloud_primary_ip" "primary_ipv6" {
  count = var.ipv6 ? 1 : 0
  name = "server-1-primary-ipv6"
  type = "ipv6"
  datacenter = "hel1-dc2"
  assignee_type = "server"
  auto_delete = true
  
  labels = {
    "managedBy" : "Terraform"
  }
}

resource "hcloud_firewall" "firewall" {
  name = "firewall-1"
  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
    description = "Inbound rule for SSH connections"
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80-85"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
    description = "Inbound rule for Web"
  }

  labels = {
    "managedBy" : "Terraform"
  }
}

resource "hcloud_ssh_key" "ssh_key" {
  name       = "ssh-key-1"
  public_key = file(var.ssh_filepath)
}

resource "hcloud_server" "server" {
  name        = "server-1"
  image       = "debian-13"
  server_type = "cax11"
  firewall_ids = [ hcloud_firewall.firewall.id ]

  public_net {
    ipv4_enabled = var.ipv4
    ipv4 = var.ipv4 ? hcloud_primary_ip.primary_ipv4[0].id : null
    ipv6_enabled = var.ipv6
    ipv6 = var.ipv6 ? hcloud_primary_ip.primary_ipv6[0].id : null
  }
  
  ssh_keys = [hcloud_ssh_key.ssh_key.id]

  labels = {
    "managedBy" : "Terraform"
  }
}

