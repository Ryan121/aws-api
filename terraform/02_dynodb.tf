resource "aws_dynamodb_table" "movie_table" {
  name           = var.dynamodb_table
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "year"
  range_key      = "title"

  attribute {
    name = "year"
    type = "N"
  }
  
  attribute {
    name = "title"
    type = "S"
  }

}