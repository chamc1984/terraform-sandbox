resource "aws_iam_role" "chatbot-role" {
  name               = "${var.system_name}-chatbot-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.chatbot-sts-policies.json

}

data "aws_iam_policy_document" "chatbot-sts-policies" {
  statement {
    sid    = ""
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "chatbot.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_policy" "chatbot-policy" {
  name   = "${var.system_name}-chatbot-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.chatbot-policy.json
}

data "aws_iam_policy_document" "chatbot-policy" {
  statement {
    sid    = "ChatbotPolicy"
    effect = "Allow"
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "lambda:InvokeFunction"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "chatbot-role-policy-attachment" {
  policy_arn = aws_iam_policy.chatbot-policy.arn
  role       = aws_iam_role.chatbot-role.name
}

resource "aws_iam_role" "lambda-role" {
  name               = "${var.system_name}-lambda-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda-sts-policies.json
}

data "aws_iam_policy_document" "lambda-sts-policies" {
  statement {
    sid    = ""
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_policy" "lambda-policy" {
  name   = "${var.system_name}-lambda-policy"
  policy = data.aws_iam_policy_document.lambda-policy.json
}

data "aws_iam_policy_document" "lambda-policy" {
  statement {
    sid    = "LambdaLoggingPolicy"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
  statement {
    sid    = "LambdaEC2Policy"
    effect = "Allow"
    actions = [
      "ec2:*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "lambda-role-policy-attachment" {
  policy_arn = aws_iam_policy.lambda-policy.arn
  role       = aws_iam_role.lambda-role.name
}
