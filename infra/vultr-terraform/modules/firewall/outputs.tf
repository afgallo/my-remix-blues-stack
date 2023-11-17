output "firewall_id" {
  value = vultr_firewall_rule.base_firewall_rule.id
}

output "firewall_group_id" {
  value = vultr_firewall_group.default_firewall_group.id
}
