# Create the Load Balancer (ALB)
resource "aws_lb" "test-alb" {
 name               = "java-react-api"
 internal           = false
 load_balancer_type = "application"
 security_groups    = [aws_security_group.lb_sg.id]
 subnet_mapping {
   subnet_id = aws_subnet.public-subnet-1.id
 }
 subnet_mapping {
   subnet_id = aws_subnet.public-subnet-2.id
 }
 enable_deletion_protection = false
 tags = {
   Name = "BH Alb"
 }
}
# HTTP listener to redirect traffic to HTTPS
resource "aws_lb_listener" "alb-listener-no-ssl-certificate" {
 load_balancer_arn = aws_lb.test-alb.arn
 port              = "80"
 protocol          = "HTTP"
 default_action {
   type = "redirect"
   redirect {
     host        = "#{host}"
     path        = "/#{path}"
     port        = "443"
     protocol    = "HTTPS"
     status_code = "HTTP_301"
   }
 }
}
# HTTPS listener to forward traffic to the target group
resource "aws_lb_listener" "alb-listener-ssl-certificate" {
 load_balancer_arn  = aws_lb.test-alb.arn
 port               = "443"
 protocol           = "HTTPS"
 ssl_policy         = "ELBSecurityPolicy-2016-08"
 certificate_arn    = var.ssl-certificate-arn
 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.test-tg.arn
 }
}
resource "aws_lb_target_group" "test-tg" {
 name        = "frontend-api-targetgroup"
 port        = 80
 protocol    = "HTTP"
 vpc_id      = aws_vpc.vpc.id
 target_type = "ip"
 health_check {
   healthy_threshold   = 2
   unhealthy_threshold = 2
   timeout             = 5
   path                = "/"
   interval            = 30
   matcher             = "200,302"
 }
}
resource "aws_lb_target_group" "backend-tg" {
 name        = "backend-targetgroup"
 port        = 8080
 protocol    = "HTTP"
 vpc_id      = aws_vpc.vpc.id
 target_type = "ip"
 health_check {
   healthy_threshold   = 2
   unhealthy_threshold = 2
   timeout             = 5
   path                = "/favicon.ico"
   interval            = 120
   matcher             = "200,404,401"
 }
}
# Rule for frontend traffic
resource "aws_lb_listener_rule" "test_rule" {
 listener_arn = aws_lb_listener.alb-listener-ssl-certificate.arn
 action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.test-tg.arn
 }
 condition {
   path_pattern {
     values = ["/"]
   }
 }
 priority = 20
 depends_on = [aws_lb_target_group.test-tg]
}
# Rule for backend traffic
resource "aws_lb_listener_rule" "backend_rule" {
 listener_arn = aws_lb_listener.alb-listener-ssl-certificate.arn
 action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.backend-tg.arn
 }
 condition {
   path_pattern {
     values = ["/api*"]
   }
 }
 priority = 1
 depends_on = [aws_lb_target_group.backend-tg]
}

# Rule for /Payroll* with priority 2
resource "aws_lb_listener_rule" "backend_payroll_rule" {
  listener_arn = aws_lb_listener.alb-listener-ssl-certificate.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend-tg.arn
  }
  condition {
    path_pattern {
      values = ["/Payroll*"]
    }
  }
  priority   = 2
  depends_on = [aws_lb_target_group.backend-tg]
}