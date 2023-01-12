/*# Backend must remain commented until the Bucket
 and the DynamoDB table are created. 
 After the creation you can uncomment it,
 run "terraform init" and then "terraform apply" */

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



# terraform {
#   backend "s3" {
#     bucket         = "angelo-terraform-state-backend"
#     key            = "terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform_state"
#   }
# }