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
