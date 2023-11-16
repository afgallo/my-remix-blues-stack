terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.17.1"
    }
  }
}

resource "vultr_load_balancer" "load_balancer" {
  region = var.region
  label  = "Web Load Balancer"

  forwarding_rules {
    frontend_protocol = "http"
    frontend_port     = 80
    backend_protocol  = "http"
    backend_port      = 3000
  }

  health_check {
    protocol            = "http"
    port                = 80
    path                = "/healthcheck"
    check_interval      = 15
    response_timeout    = 5
    unhealthy_threshold = 3
    healthy_threshold   = 5
  }

  attached_instances = var.attached_servers

  firewall_rules {
    ip_type = "v4"
    port    = "80"
    source  = "0.0.0.0/0"
  }
}
