/*# Backend must remain commented until the Bucket
 and the DynamoDB table are created.  */

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.33.0"
    }
  }

  backend "s3" {
    bucket         = "rs-terraform-state-backend-120123"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state"
  }

}

provider "aws" {
  profile = "default"
  region = var.aws_region
}

/* Provision dyno_db table  and s3 backend via terraform when using a local remote backend  */

# resource "aws_dynamodb_table" "terraform-lock" {
#     name           = "terraform_state"
#     read_capacity  = 5
#     write_capacity = 5
#     hash_key       = "LockID"
#     attribute {
#         name = "LockID"
#         type = "S"
#     }
#     tags = {
#         "Name" = "DynamoDB Terraform State Lock Table"
#     }
# }

# resource "aws_s3_bucket" "bucket" {
#     bucket = "angelo-terraform-state-backend"
#     versioning {
#         enabled = true
#     }
#     server_side_encryption_configuration {
#         rule {
#             apply_server_side_encryption_by_default {
#                 sse_algorithm = "AES256"
#             }
#         }
#     }
#     object_lock_configuration {
#         object_lock_enabled = "Enabled"
#     }

# }