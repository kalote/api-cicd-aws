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
