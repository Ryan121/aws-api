# data "template_file" "lambdapolicy" {
#   template = "${file("./policies/policy.json")}"
# }

resource "aws_iam_policy" "lambda_exec_role" {
  name        = "LambdaPolicy"
  path        = "/"
  description = "IAM policy for the Lambda function"
  # policy      = data.template_file.lambdapolicy.rendered
  policy      = file("./policies/policy.json")
}

resource "aws_iam_role" "lambda_exec" {
  name = "LambdaDdbPostRequest"
  assume_role_policy = file("policies/lambda-role.json")
}


resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_exec_role.arn
}
