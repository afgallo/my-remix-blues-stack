output "web_server_1_id" {
  value = module.web_servers.web01_instance_id
}

output "web_server_2_id" {
  value = module.web_servers.web02_instance_id
}

output "db_server_id" {
  value = module.db_server.db_instance_id
}

output "load_balancer_server_ip" {
  value = module.load_balancer.load_balancer_ip
}

