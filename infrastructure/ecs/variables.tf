variable "target_group_arn" {
  description = "The LB target group ARN"
  type        = string
}

variable "app_version" {
  description = "application version"
  type        = string
  default     = "latest"
}

variable "repo_url" {
  description = "The docker registry URL where our application is stored"
  type        = string
}

variable "subnet1_id" {
  description = "Subnet 1 ID"
  type        = string
}

variable "subnet2_id" {
  description = "Subnet 2 ID"
  type        = string
}

variable "sg_app_id" {
  description = "Security group for application id"
  type        = string
}
