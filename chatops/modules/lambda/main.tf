resource "aws_lambda_function" "this" {
  function_name    = "${var.system_name}-function"
  runtime          = var.runtime
  filename         = var.filename
  source_code_hash = var.source_code_hash
  handler          = var.handler
  role             = var.iam_role_arn
  publish          = var.publish
  memory_size      = var.memory_size
  timeout          = var.timeout
}
