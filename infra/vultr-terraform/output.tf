output "web_server_1_ip" {
  value = module.web_servers.web01_instance_ip
}

output "web_server_2_ip" {
  value = module.web_servers.web02_instance_ip
}

output "db_server_ip" {
  value = module.db_server.db_instance_ip
}

output "load_balancer_server_ip" {
  value = module.load_balancer.load_balancer_ip
}

