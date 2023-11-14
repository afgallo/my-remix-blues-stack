resource "vultr_instance" "db" {
  plan        = var.plan
  region      = var.region
  os_id       = var.os_id
  label       = "DB Server"
  ssh_key_ids = var.ssh_key_id
  vpc_id      = var.vpc_id
  hostname    = "db"
  tags        = ["db"]
  backups     = "disabled"
}
