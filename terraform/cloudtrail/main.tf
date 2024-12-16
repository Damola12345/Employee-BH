# configured aws provider with proper credentials
provider "aws" {
  region  = "eu-west-1"
  profile = ""
}

module "cloudtrail_s3_bucket" {
  source = "cloudposse/cloudtrail-s3-bucket/aws"
  stage  = "prod"
  name   = "employee-BH-logs"
}

module "cloudtrail" {
  source = "cloudposse/cloudtrail/aws"
  stage                         = "prod"
  name                          = "employee-BH"
  enable_log_file_validation    = true
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true
  s3_bucket_name                = module.cloudtrail_s3_bucket.bucket_id
}