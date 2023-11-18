terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
    }
  }
}

resource "vultr_vpc2" "default_private_network" {
  description   = "Default private network"
  region        = var.region
  ip_block      = var.ip_block
  prefix_length = 24
}
