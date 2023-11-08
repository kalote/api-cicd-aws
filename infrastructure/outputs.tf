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

output "subnet_public_id" {
  description = "The public subnet ID"
  value       = module.network.subnet_public_id
}

output "subnet_private_id" {
  description = "The private subnet ID"
  value       = module.network.subnet_private_id
}

output "ecr_registry_url" {
  description = "The ECR registry URL"
  value       = module.ecr.repository_url
}

output "ecr_registry_id" {
  description = "The ECR registry ID"
  value       = module.ecr.registry_id
}
