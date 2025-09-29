provider "aws" {
  region = "us-east-1"
}

# S3 bucket module
module "s3" {
  source      = "./modules/s3"
  bucket_name = "test-bucket"
  tags = {
    "environment": "dev"
  }
}

# Lambda module
module "lambda" {
  source             = "./modules/lambda"
  project            = "test"
  s3_bucket_name     = module.s3.bucket_name
  s3_bucket_arn      = module.s3.bucket_arn
  lambda_code_bucket = "lambda-code-storage"
  lambda_code_key    = "functions/test_file.zip"
  tags = {
    "environment": "dev"
  }
}
