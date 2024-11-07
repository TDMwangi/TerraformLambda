variable "source_file" {
  description = "File to include in the ZIP archive"
  type        = string
}

variable "output_path" {
  description = "The path where the resulting archive file will be saved"
  type        = string
}

variable "function_name" {
  description = "Unique name for the Lambda Function"
  type        = string
}

variable "runtime" {
  description = "Identifier of the function's runtime"
  type        = string
}

variable "handler" {
  description = "The function that will be executed when the Lambda function is triggered"
  type        = string
}

variable "retention_in_days" {
  description = "The number of days to retain the log events in the log group"
  type        = number
}
