variable "project" {
  type        = string
  description = "Project name prefix"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name the Lambda will read from"
}

variable "s3_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket the Lambda will read from"
}

variable "lambda_code_bucket" {
  type        = string
  description = "S3 bucket where Lambda zip code is stored"
}

variable "lambda_code_key" {
  type        = string
  description = "S3 object key for Lambda code package"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}