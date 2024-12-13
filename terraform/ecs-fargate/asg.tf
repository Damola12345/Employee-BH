# Auto Scaling Target for Frontend Service
resource "aws_appautoscaling_target" "frontend_target" {
 service_namespace  = "ecs"
 resource_id        = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.frontend-service.name}"
 scalable_dimension = "ecs:service:DesiredCount"
 min_capacity       = 2
 max_capacity       = 4
}
# Auto Scaling Policy for Frontend - Scale Up
resource "aws_appautoscaling_policy" "frontend_scale_up" {
 name               = "frontend_scale_up"
 service_namespace  = "ecs"
 resource_id        = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.frontend-service.name}"
 scalable_dimension = "ecs:service:DesiredCount"
 step_scaling_policy_configuration {
   adjustment_type         = "ChangeInCapacity"
   cooldown                = 60
   metric_aggregation_type = "Maximum"
   step_adjustment {
     metric_interval_lower_bound = 0
     scaling_adjustment          = 1
   }
 }
}
# Auto Scaling Policy for Frontend - Scale Down
resource "aws_appautoscaling_policy" "frontend_scale_down" {
 name               = "frontend_scale_down"
 service_namespace  = "ecs"
 resource_id        = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.frontend-service.name}"
 scalable_dimension = "ecs:service:DesiredCount"
 step_scaling_policy_configuration {
   adjustment_type         = "ChangeInCapacity"
   cooldown                = 60
   metric_aggregation_type = "Maximum"
   step_adjustment {
     metric_interval_lower_bound = 0
     scaling_adjustment          = -1
   }
 }
}
# Auto Scaling Target for Backend Service
resource "aws_appautoscaling_target" "backend_target" {
 service_namespace  = "ecs"
 resource_id        = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.backend-service.name}"
 scalable_dimension = "ecs:service:DesiredCount"
 min_capacity       = 2
 max_capacity       = 4
}
# Auto Scaling Policy for Backend - Scale Up
resource "aws_appautoscaling_policy" "backend_scale_up" {
 name               = "backend_scale_up"
 service_namespace  = "ecs"
 resource_id        = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.backend-service.name}"
 scalable_dimension = "ecs:service:DesiredCount"
 step_scaling_policy_configuration {
   adjustment_type         = "ChangeInCapacity"
   cooldown                = 60
   metric_aggregation_type = "Maximum"
   step_adjustment {
     metric_interval_lower_bound = 0
     scaling_adjustment          = 1
   }
 }
}
# Auto Scaling Policy for Backend - Scale Down
resource "aws_appautoscaling_policy" "backend_scale_down" {
 name               = "backend_scale_down"
 service_namespace  = "ecs"
 resource_id        = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.backend-service.name}"
 scalable_dimension = "ecs:service:DesiredCount"
 step_scaling_policy_configuration {
   adjustment_type         = "ChangeInCapacity"
   cooldown                = 60
   metric_aggregation_type = "Maximum"
   step_adjustment {
     metric_interval_lower_bound = 0
     scaling_adjustment          = -1
   }
 }
}
