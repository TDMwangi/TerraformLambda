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
