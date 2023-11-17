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

module "firewall" {
  source = "./modules/firewall"
}

module "web_servers" {
  source            = "./modules/web-server"
  vpc_id            = var.vpc_id
  ssh_key_id        = var.ssh_key_id
  firewall_group_id = module.firewall.firewall_group_id
}

module "db_server" {
  source            = "./modules/db-server"
  vpc_id            = var.vpc_id
  ssh_key_id        = var.ssh_key_id
  firewall_group_id = module.firewall.firewall_group_id
}

module "load_balancer" {
  source           = "./modules/load-balancer"
  attached_servers = module.web_servers.web_instance_ids
}

