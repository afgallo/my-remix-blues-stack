variable "region" {
  description = "Network region"
  type        = string
  default     = "syd"
}

variable "ip_block" {
  description = "IP block for network"
  type        = number
  default     = 24
}
