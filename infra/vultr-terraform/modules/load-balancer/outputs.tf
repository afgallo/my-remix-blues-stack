output "load_balancer_ip" {
  value       = vultr_load_balancer.load_balancer.ip
  description = "The IP address of the load balancer"
}
