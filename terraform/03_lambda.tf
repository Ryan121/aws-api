resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.s3_bucket
  force_destroy = true
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.lambda_bucket.id
  acl    = "private"
}

data "archive_file" "lambda_zip" {
  type = "zip"

  source_dir  = "../lambda"
  output_path = "../lambda.zip"
}

resource "aws_s3_object" "lambda_object" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "lambda.zip"
  source = data.archive_file.lambda_zip.output_path

  etag = filemd5(data.archive_file.lambda_zip.output_path)
}

//Define lambda function
resource "aws_lambda_function" "apigw_lambda_ddb" {
  function_name = "${var.lambda_name}"
  description = "Serverless API Lambda Pattern"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_object.key

  runtime = "python3.8"
  handler = "demo-app.lambda_handler"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
  
  environment {
    variables = {
      DDB_TABLE = var.dynamodb_table
    }
  }
  depends_on = [aws_cloudwatch_log_group.lambda_logs]
  
}