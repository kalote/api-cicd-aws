variable "subnet_private_id" {
  description = "The private subnet id"
  type        = string
}

variable "subnet_public_id" {
  description = "The public subnet id"
  type        = string
}

variable "sg_app_id" {
  description = "The SG id for the application"
  type        = string
}

variable "sg_mongo_id" {
  description = "The SG id for mongo / redis"
  type        = string
}

variable "ecr_repo_url" {
  description = "The ECR repository URL"
  type        = string
}

variable "app_version" {
  description = "The app version to run"
  type        = string
  default     = "latest"
}

variable "registry_id" {
  description = "The ECR Registry id"
  type        = string
}

variable "registry_region" {
  description = "The region of the ECR registry"
  type        = string
}
