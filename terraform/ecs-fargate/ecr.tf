# Frontend ECR repository
resource "aws_ecr_repository" "frontend_repo" {
  name                 = "frontend-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

# Backend ECR repository
resource "aws_ecr_repository" "backend_repo" {
  name                 = "backend-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
