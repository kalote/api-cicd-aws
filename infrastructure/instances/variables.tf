variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC ID"
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

variable "sg_mongo_id" {
  description = "Security group for mongo id"
  type        = string
}

variable "log_bucket_name" {
  description = "Bucket name for the ALB logs"
  type        = string
}
