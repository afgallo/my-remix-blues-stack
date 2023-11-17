terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
    }
  }
}

resource "vultr_firewall_group" "default_firewall_group" {
  description = "Base firewall group"
}

resource "vultr_firewall_rule" "base_firewall_rule" {
  firewall_group_id = vultr_firewall_group.default_firewall_group.id
  protocol          = "tcp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = "22"
  notes             = "Allows ssh connection"
}
