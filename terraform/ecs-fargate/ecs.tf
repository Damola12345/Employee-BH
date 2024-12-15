resource "aws_ecs_cluster" "ecs-cluster" {
 name = "java-react-api"
 setting {
   name  = "containerInsights"
   value = "enabled"
 }
}

resource "aws_cloudwatch_log_group" "logs" {
 name = "java-react-api-logs"
 retention_in_days = 7

}
# Frontend Task Definition
resource "aws_ecs_task_definition" "frontend-task" {
 family                = "frontend-task"
 requires_compatibilities = ["FARGATE"]
 network_mode          = "awsvpc"
 cpu                   = 256
 memory                = 512
 execution_role_arn    = aws_iam_role.ecs_role.arn
 container_definitions = jsonencode([
   {
     name      = "frontend-container"
     image     = var.frontend_image
     cpu       = 128
     memory    = 256
     essential = true
     
     portMappings = [
       {
         containerPort = 80
       }
     ]
     logConfiguration = {
       logDriver = "awslogs"
       options = {
         awslogs-group         = aws_cloudwatch_log_group.logs.name
         awslogs-region        = "eu-west-1"
         awslogs-stream-prefix = "frontend"
       }
     }
   }
 ])
}
# Backend Task Definition
resource "aws_ecs_task_definition" "backend-task" {
  family                   = "backend-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_role.arn

  container_definitions = jsonencode([
    {
      name      = "backend-container"
      image     = var.backend_image
      cpu       = 128
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 8080
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.logs.name
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "backend"
        }
      }
      environment = [
        {
          name  = "DATABASE_HOST"
          value = "testclouddb.cxyiw0egiwdj.eu-west-1.rds.amazonaws.com"
        },
        {
          name  = "DATABASE_PORT"
          value = "3306"
        },
        {
          name  = "DATABASE_NAME"
          value = "hbdb"
        }
      ]
    }
  ])
}

# Frontend ECS Service
resource "aws_ecs_service" "frontend-service" {
 name            = "frontend-service"
 cluster         = aws_ecs_cluster.ecs-cluster.id
 task_definition = aws_ecs_task_definition.frontend-task.arn
 desired_count   = 1
 launch_type     = "FARGATE"
 network_configuration {
   subnets         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
   security_groups = [aws_security_group.container_sg.id]
   assign_public_ip = false
 }
 load_balancer {
   target_group_arn = aws_lb_target_group.test-tg.arn
   container_name   = "frontend-container"
   container_port   = 80
 }
 depends_on = [aws_lb_listener.alb-listener-ssl-certificate]
}
# Backend ECS Service
resource "aws_ecs_service" "backend-service" {
 name            = "backend-service"
 cluster         = aws_ecs_cluster.ecs-cluster.id
 task_definition = aws_ecs_task_definition.backend-task.arn
 desired_count   = 1
 launch_type     = "FARGATE"
 network_configuration {
   subnets         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
   security_groups = [aws_security_group.container_sg.id]
   assign_public_ip = false
 }
 load_balancer {
   target_group_arn = aws_lb_target_group.backend-tg.arn
   container_name   = "backend-container"
   container_port   = 8080
 }
 depends_on = [aws_lb_listener.alb-listener-ssl-certificate]
}
