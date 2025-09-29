# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.project}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# IAM Policy for lambda
resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.project}-lambda-policy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*"
        ]
      }
    ]
  })
}

# code from S3
data "aws_s3_bucket_object" "lambda_zip" {
  bucket = var.lambda_code_bucket
  key    = var.lambda_code_key
}

resource "aws_lambda_function" "this" {
  function_name = "${var.project}-lambda"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.handler"
  runtime       = "python3.9"

  s3_bucket        = data.aws_s3_bucket_object.lambda_zip.bucket
  s3_key           = data.aws_s3_bucket_object.lambda_zip.key
  source_code_hash = data.aws_s3_bucket_object.lambda_zip.etag

  environment {
    variables = {
      UPLOAD_BUCKET = var.s3_bucket_name
    }
  }

  tags = var.tags

  depends_on = [aws_iam_role_policy.lambda_policy]
}
