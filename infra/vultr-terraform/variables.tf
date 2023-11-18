variable "vultr_api_key" {
  description = "API Key for Vultr provider"
  type        = string
}

variable "ssh_key_id" {
  description = "The ssh key to be used on the server"
  type        = string
}

variable "vpc_id" {
  description = "The VPC 2.0 id"
  type        = string
}
