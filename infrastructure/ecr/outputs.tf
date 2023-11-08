output "repository_url" {
  value = aws_ecr_repository.app_image.repository_url
}

output "registry_id" {
  value = aws_ecr_repository.app_image.registry_id
}
