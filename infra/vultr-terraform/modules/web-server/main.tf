terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.17.1"
    }
  }
}

resource "vultr_instance" "web01" {
  plan              = var.plan
  region            = var.region
  os_id             = var.os_id
  label             = "Web Server 02"
  ssh_key_ids       = [var.ssh_key_id]
  vpc2_ids          = [var.vpc_id]
  hostname          = "web01"
  tags              = ["web"]
  backups           = "disabled"
  firewall_group_id = var.firewall_group_id
}

resource "vultr_instance" "web02" {
  plan              = var.plan
  region            = var.region
  os_id             = var.os_id
  label             = "Web Server 01"
  ssh_key_ids       = [var.ssh_key_id]
  vpc2_ids          = [var.vpc_id]
  hostname          = "web02"
  tags              = ["web"]
  backups           = "disabled"
  firewall_group_id = var.firewall_group_id
}
