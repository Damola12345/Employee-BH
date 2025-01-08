# VPC Variables
variable "vpc-cidr" {
  default       = "10.0.0.0/16"
  description   = "VPC CIDR Block"
  type          = string
}

variable "availability_zones" {
  default = ["eu-west-1a", "eu-west-1b"]
}


variable "public-subnet-1-cidr" {
  default       = "10.0.0.0/24"
  description   = "Public Subnet 1 CIDR Block"
  type          = string
}

variable "public-subnet-2-cidr" {
  default       = "10.0.1.0/24"
  description   = "Public Subnet 2 CIDR Block"
  type          = string
}

variable "private-subnet-1-cidr" {
  default       = "10.0.2.0/24"
  description   = "Private Subnet 1 CIDR Block"
  type          = string
}

variable "private-subnet-2-cidr" {
  default       = "10.0.3.0/24"
  description   = "Private Subnet 2 CIDR Block"
  type          = string
}

variable "private-subnet-3-cidr" {
  default       = "10.0.4.0/24"
  description   = "Private Subnet 3 CIDR Block"
  type          = string
}

variable "private-subnet-4-cidr" {
  default       = "10.0.5.0/24"
  description   = "Private Subnet 4 CIDR Block"
  type          = string
}

# SNS Topic Variables
variable "operator-email" {
  default       = "ajiboladamola789@gmail.com"
  description   = "A Valid Email Address"
  type          = string
}

variable "cpu" {
  default       = "128"
  description   = "CPU"
  type          = number
}
variable "memory" {
  default       = "256"
  description   = "MEMORY"
  type          = number
}

variable "backend_image" {
  default       = "xxxxx.dkr.ecr.eu-west-1.amazonaws.com/backend-app"
  description   = "backend image"
}
variable "frontend_image" {
  default       = "xxxxxx.dkr.ecr.eu-west-1.amazonaws.com/frontend-app"
  description   = "frontend image"
}

# RDS Variables
variable "database-instance-class" {
  default       = "db.t3.micro"
  description   = "The Database Instance Type"
  type          = string
}

variable "database-instance-identifier" {
  default       = "testclouddb"
  description   = "The Database Instance Identifier"
  type          = string
}

variable "multi-az-deployment" {
  default       = false
  description   = "Create a Standby DB Instance"
  type          = bool
}

variable "ssl-certificate-arn" {
  default       = "arn:aws:acm:eu-west-1:xxxxxxxx:certificate/xxxxx"
  description   = "SSL Certificate Arn"
  type          = string
}

variable "domain-name" {
  default       = "xxxxxx"
  description   = "The Domain Name"
  type          = string
}

