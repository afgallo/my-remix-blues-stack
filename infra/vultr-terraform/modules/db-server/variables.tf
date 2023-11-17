variable "plan" {
  description = "Plan for the instance"
  type        = string
  default     = "vc2-1c-1gb"
}

variable "region" {
  description = "Region for the instance"
  type        = string
  default     = "syd"
}

variable "os_id" {
  description = "Operating system id. Default value is Ubuntu 23.04."
  type        = number
  default     = 2104
}

variable "ssh_key_id" {
  description = "The ssh key to be used on the server"
  type        = string
}

variable "firewall_group_id" {
  description = "The firewall group id"
  type        = string
}

variable "vpc2_ids" {
  description = "The vpc2 ids"
  type        = list(string)
}
