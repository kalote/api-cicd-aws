variable "vpc_cidr" {
  description = "The VPC CIDR range"
  type        = string
  default     = "10.10.0.0/16"
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}
