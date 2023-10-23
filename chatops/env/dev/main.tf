module "iam" {
  source = "../../modules/iam"

  system_name = local.system_name
}

module "chatbot" {
  source = "../../modules/chatbot"

  system_name = local.system_name

  slack_workspace_id = var.slack_workspace_id
  iam_role_arn       = module.iam.chatbot-role.arn
  guardrail_policies = [module.iam.chatbot-policy.arn]
  logging_level      = "NONE"
  slack_channel_id   = var.slack_channel_id
}

module "lambda" {
  source = "../../modules/lambda"

  system_name = local.system_name

  handler          = "src/lambda_function.lambda_handler"
  iam_role_arn     = module.iam.lambda-role.arn
  filename         = data.archive_file.function_zip.output_path
  runtime          = "python3.11"
  source_code_hash = data.archive_file.function_zip.output_base64sha256
  timeout          = 10
}
