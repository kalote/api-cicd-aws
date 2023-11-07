output "vpc_id" {
  description = "The main VPC ID"
  value       = aws_vpc.main.id
}

output "subnet1_id" {
  description = "The subnet 1 ID"
  value       = aws_subnet.subnet1.id
}

output "subnet2_id" {
  description = "The subnet 2 ID"
  value       = aws_subnet.subnet2.id
}

output "sg_app_id" {
  description = "The app security group ID"
  value       = aws_security_group.security_group_app.id
}

output "sg_mongo_id" {
  description = "The mongo security group ID"
  value       = aws_security_group.security_group_mongo.id
}
