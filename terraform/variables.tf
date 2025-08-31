variable "hcloud_token" {
  type = string
}

variable "ipv4" {
  type = bool
}

variable "ipv6" {
  type = bool
  default = true
}

variable "ssh_filepath" {
  type = string
  default = "~/.ssh/id_ed25519.pub"
}