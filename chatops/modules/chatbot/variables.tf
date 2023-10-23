variable "system_name" {
  description = "AWSリソース作成時のプレフィックスとなるシステム名"
  type        = string
}

variable "guardrail_policies" {
  description = "ガードレールIAMポリシーのARNリスト"
  type        = list(string)
  default     = []
}

variable "iam_role_arn" {
  description = "IAMロールARN"
  type        = string
}

variable "logging_level" {
  description = "ERROR|INFO|NONE"
  type        = string
  default     = "NONE"
}

variable "slack_channel_id" {
  description = "SlackチャンネルID"
  type        = string
}

variable "slack_workspace_id" {
  description = "SlackワークスペースID"
  type        = string
}
