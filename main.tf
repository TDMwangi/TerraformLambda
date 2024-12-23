provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
}

module "lambda" {
  source = "./modules"

  function_name = "my-lambda-function"
  runtime       = "python3.11"
  handler       = "lambda_function.lambda_handler"

  source_file = "./modules/functions/lambda_function.py"
  output_path = "./modules/functions/lambda_function_payload.zip"

  retention_in_days = 14
}
