output "chatbot-role" {
  value = aws_iam_role.chatbot-role
}

output "chatbot-policy" {
  value = aws_iam_policy.chatbot-policy
}

output "lambda-role" {
  value = aws_iam_role.lambda-role
}
