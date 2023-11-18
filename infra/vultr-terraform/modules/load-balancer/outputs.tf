output "load_balancer_ip" {
  value       = vultr_load_balancer.load_balancer.ipv4
  description = "The IP address of the load balancer"
}
