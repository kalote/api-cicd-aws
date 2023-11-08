output "mongo_instance_ip" {
  description = "The mongo instance private IP"
  value       = aws_instance.mongo.private_ip
}

output "redis_instance_ip" {
  description = "The redis instance private IP"
  value       = aws_instance.redis.private_ip
}

output "application_instance_ip" {
  description = "The app instance public IP"
  value       = aws_instance.application.public_ip
}
