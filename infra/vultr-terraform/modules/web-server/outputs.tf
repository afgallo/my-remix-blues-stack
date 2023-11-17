output "web01_instance_id" {
  value = vultr_instance.web01.id
}

output "web02_instance_id" {
  value = vultr_instance.web02.id
}

output "instance_ids" {
  value = [vultr_instance.web01.id, vultr_instance.web02.id]
}
