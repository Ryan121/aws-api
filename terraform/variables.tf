
variable "aws_region" {
  description = "The AWS region to create resources in."
  default     = "us-east-1"
}

# ---------------------------------------------------------------------------------- #

variable "bucket_name" {
  description = "S3 bucket name"
  default     = "rs-terraform-state-backend-120123"
}

# ---------------------------------------------------------------------------------- #

variable "terraform_table_name" {
  description = "State table name"
  default     = "terraform_state"
}

# ---------------------------------------------------------------------------------- #

variable "dynamodb_table" {
  description = "Movie table name"
  default     = "Movies"
}


variable "s3_bucket" {
  description = "Lambda s3 bucket"
  default     = "rs-lambdas3bucket120123"
}


variable "lambda_name" {
  description = "The name of the lambda function"
  default     = "DemoAPILambda"
}


variable "lambda_log_retention" {
  description = "Day to retain lambda logs"
  default     = 7
}

variable "apigw_name" {
  description = "Name of API gateway"
  default     = "demo-movie-api-address"
}
