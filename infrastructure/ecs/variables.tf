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
