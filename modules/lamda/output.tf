output "lambda_function_name" {
  value       = aws_lambda_function.this.function_name
  description = "Name of the Lambda function"
}

output "lambda_arn" {
  value       = aws_lambda_function.this.arn
  description = "ARN of Lambda"
}
