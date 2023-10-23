resource "aws_cloudcontrolapi_resource" "this" {
  type_name = "AWS::Chatbot::SlackChannelConfiguration"

  desired_state = jsonencode({
    ConfigurationName : var.system_name,
    GuardrailPolicies : var.guardrail_policies,
    IamRoleArn : var.iam_role_arn,
    LoggingLevel : var.logging_level,
    SlackChannelId : var.slack_channel_id,
    SlackWorkspaceId : var.slack_workspace_id
  })
}
