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

variable "vpc_id" {
  description = "The VPC 2.0 id"
  type        = string
}
