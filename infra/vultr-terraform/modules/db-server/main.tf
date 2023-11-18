terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
    }
  }
}

resource "vultr_instance" "db" {
  plan              = var.plan
  region            = var.region
  os_id             = var.os_id
  label             = "DB Server"
  ssh_key_ids       = [var.ssh_key_id]
  vpc2_ids          = var.vpc2_ids
  hostname          = "db"
  tags              = ["db"]
  backups           = "disabled"
  firewall_group_id = var.firewall_group_id
}
