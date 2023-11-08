output "s3_bucket_arn" {
  value       = module.state.s3_bucket_arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = module.state.dynamodb_table_name
  description = "The table name of the dynamoDB"
}

output "vpc_id" {
  description = "The main VPC ID"
  value       = module.network.vpc_id
}

output "subnet1_id" {
  description = "The subnet 1 ID"
  value       = module.network.subnet1_id
}

output "subnet2_id" {
  description = "The subnet 2 ID"
  value       = module.network.subnet2_id
}

output "sg_app_id" {
  description = "The app security group ID"
  value       = module.network.sg_app_id
}

output "sg_mongo_id" {
  description = "The mongo security group ID"
  value       = module.network.sg_mongo_id
}

# output "alb_dns_name" {
#   description = "The LB DNS name"
#   value       = module.instances.alb_dns_name
# }

output "ecr_registry_url" {
  description = "The ECR registry URL"
  value       = module.ecr.repository_url
}

# output "target_group_arn" {
#   description = "The target group ARN"
#   value       = module.instances.target_group_arn
# }
