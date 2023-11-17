variable "region" {
  description = "Network region"
  type        = string
  default     = "syd"
}

variable "ip_block" {
  description = "IP block for network"
  type        = string
  default     = "10.0.0.0"
}
