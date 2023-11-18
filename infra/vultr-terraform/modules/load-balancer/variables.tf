variable "region" {
  description = "Region for the instance"
  type        = string
  default     = "syd"
}

variable "attached_servers" {
  description = "The name of the servers to attach to this LB"
  type        = list(string)
}
