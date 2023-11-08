output "vpc_id" {
  description = "The main VPC ID"
  value       = aws_vpc.main.id
}

output "subnet_public_id" {
  description = "The public subnet ID"
  value       = aws_subnet.subnet_public.id
}

output "subnet_private_id" {
  description = "The private subnet ID"
  value       = aws_subnet.subnet_private.id
}

output "sg_app_id" {
  description = "The SG for the application"
  value       = aws_security_group.security_group_app.id
}

output "sg_mongo_id" {
  description = "The SG for the mongo / redis"
  value       = aws_security_group.security_group_mongo.id
}
