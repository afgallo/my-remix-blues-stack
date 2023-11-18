output "web01_instance_ip" {
  value = vultr_instance.web01.main_ip
}

output "web02_instance_ip" {
  value = vultr_instance.web02.main_ip
}

output "web_instance_ids" {
  value = [vultr_instance.web01.id, vultr_instance.web02.id]
}
