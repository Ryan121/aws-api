
variable "region" {
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

