
# Create Security Group for the Database
resource "aws_security_group" "database-security-group" {
  name        = "Database Security Group"
  description = "Enable MYSQL/Aurora access on Port 3306"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "MYSQL/Aurora Access"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.container_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database Security Group"
  }
}

# Security Group for the Container
resource "aws_security_group" "container_sg" {
  name        = "java-react-container"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id
  # depends_on  = [aws_security_group.lb_sg]

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.lb_sg.id]
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Container Security Group"
  }
}

# Security Group for the Load Balancer
resource "aws_security_group" "lb_sg" {
  name        = "java-react-alb"
  description = "Allow load balancer traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "HTTP Access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS Access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB Security Group"
  }
}
