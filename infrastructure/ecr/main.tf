resource "aws_ecr_repository" "app_image" {
  name                 = "app_image"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
