# Define the assume role policy document for Lambda
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Define the Lambda permissions
data "aws_iam_policy_document" "lambda_iam_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "Lambda:*",
      "logs:*"
    ]

    resources = ["*"]
  }
}

# Create an archive from the source file
data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.source_file
  output_path = var.output_path
}

# Create the IAM role
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam-for-lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

# Create the policy
resource "aws_iam_policy" "lambda_iam_policy" {
  name   = "lambda-iam-policy"
  policy = data.aws_iam_policy_document.lambda_iam_policy_document.json
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_iam_policy.arn
}

# Create the Lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  filename      = var.output_path
  runtime       = var.runtime
  handler       = var.handler
  role          = aws_iam_role.iam_for_lambda.arn

  source_code_hash = data.archive_file.lambda.output_base64sha256
}

# CloudWatch log group for the Lambda function
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.retention_in_days
}
