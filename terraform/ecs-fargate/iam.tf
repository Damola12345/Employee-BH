#ECS role and policy
# ECS role and policy document
data "aws_iam_policy_document" "ecs_tasks_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# IAM Role for ECS Task execution
resource "aws_iam_role" "ecs_role" {
  name               = "java-react-api-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_role.json
}

# Attach Amazon ECS Full Access policy
resource "aws_iam_role_policy_attachment" "AmazonECS_FullAccess" {
  role       = aws_iam_role.ecs_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

# Attach ECS Task Execution Role policy
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# # Attach RDS Full Access policy
# resource "aws_iam_role_policy_attachment" "rds_full_access" {
#   role       = aws_iam_role.ecs_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
# }

# # Attach RDS Data Full Access policy (for managing RDS data through APIs like Data API)
# resource "aws_iam_role_policy_attachment" "rds_data_full_access" {
#   role       = aws_iam_role.ecs_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess"
# }

