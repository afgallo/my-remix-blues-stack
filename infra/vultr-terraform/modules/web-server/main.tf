resource "vultr_instance" "web01" {
  plan           = var.plan
  region         = var.region
  os_id          = var.os_id
  label          = "Web Server 02"
  ssh_key_ids    = var.ssh_key_id
  vpc_id         = var.vpc_id
  hostname = "web01"
  tags = ["web"]
  backups = "disabled"
}

resource "vultr_instance" "web02" {
  plan           = var.plan
  region         = var.region
  os_id          = var.os_id
  label          = "Web Server 02"
  ssh_key_ids    = var.ssh_key_id
  vpc_id         = var.vpc_id
  hostname = "web02"
  tags = ["web"]
  backups = "disabled"
}
