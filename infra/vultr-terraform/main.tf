terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.17.1"
    }
  }
}

provider "vultr" {
  api_key = var.vultr_api_key
}

module "web_servers" {
  source = "./modules/web-server"
}

module "db_server" {
  source = "./modules/db-server"
}

module "load_balancer" {
  source           = "./modules/load-balancer"
  attached_servers = [module.web_servers.web01.id, module.web_server.web02.id]
}

