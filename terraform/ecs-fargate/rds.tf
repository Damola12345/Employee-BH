# Create Database Subnet Group
# terraform aws db subnet group
resource "aws_db_subnet_group" "database-subnet-group" {
  name         = "database subnets"
  subnet_ids   = [aws_subnet.private-subnet-3.id, aws_subnet.private-subnet-4.id]
  # subnet_ids   = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
  description  = "Subnets for Database Instance"

  tags   = {
    Name = "Database Subnets"
  }
}

# Database Instance
resource "aws_db_instance" "database-instance" {
  allocated_storage       = "10"
  engine                  = "mysql"
  engine_version          = "8.0"
  db_name                 = "hbdb"
  username                = "testhb"
  password                = "dbPassword"
  publicly_accessible     = false
  instance_class          = "${var.database-instance-class}"
  skip_final_snapshot     = true
  availability_zone       = "eu-west-1a"
  identifier              = "${var.database-instance-identifier}"
  db_subnet_group_name    = aws_db_subnet_group.database-subnet-group.name
  multi_az                = "${var.multi-az-deployment}"
  vpc_security_group_ids  = [aws_security_group.database-security-group.id]
  backup_retention_period = 7
  backup_window = "03:00-04:00" 
  maintenance_window = "mon:04:00-mon:04:30"
  storage_encrypted = true
}