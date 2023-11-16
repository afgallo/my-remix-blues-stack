output "web_server_1_ip" {
  value = module.web_servers.web_01_instance_id
}

output "web_server_2_ip" {
  value = module.web_servers.web_02_instance_id
}

output "db_server_ip" {
  value = module.db_server.db_instance_id
}

output "load_balancer_server_ip" {
  value = module.load_balancer.load_balancer_ip
}

