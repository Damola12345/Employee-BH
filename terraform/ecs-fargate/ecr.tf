# # Frontend ECR repository
# resource "aws_ecr_repository" "frontend_repo" {
#   name                 = "frontend-ap"
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = false
#   }
# }

# # Backend ECR repository
# resource "aws_ecr_repository" "backend_repo" {
#   name                 = "backend-ap"
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = false
#   }
# }
