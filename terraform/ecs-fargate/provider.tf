terraform {
#   required_version = ">= 1.3.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-ecsapi-state"
    key            = "ecs/terraform.tfstate"
    region         = "us-east-1"
    # For state lock
    dynamodb_table = "terraform-ecs-locks"
    encrypt        = true
  }
}

provider "aws" {
  region  = "us-east-1"
  # profile = ""

}