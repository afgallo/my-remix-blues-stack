output "web_server_1_ip" {
  value = module.web_01_instance_id.instance_ip
}

output "web_server_2_ip" {
  value = module.web_02_instance_id.instance_ip
}

output "db_server_ip" {
  value = module.db_instance_id.instance_ip
}

output "load_balancer_server_ip" {
  value = module.load_balancer_ip
}

