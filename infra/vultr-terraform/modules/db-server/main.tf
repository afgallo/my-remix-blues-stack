terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.17.1"
    }
  }
}

resource "vultr_instance" "db" {
  plan        = var.plan
  region      = var.region
  os_id       = var.os_id
  label       = "DB Server"
  ssh_key_ids = [var.ssh_key_id]
  vpc2_ids    = [var.vpc_id]
  hostname    = "db"
  tags        = ["db"]
  backups     = "disabled"
}
