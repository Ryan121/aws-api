resource "aws_cloudwatch_log_group" "lambda_logs" {
  name = "/lambda/${var.lambda_name}"

  retention_in_days = var.lambda_log_retention
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/api_gw/${var.apigw_name}"

  # retention_in_days = var.apigw_log_retention
  retention_in_days = var.lambda_log_retention
}