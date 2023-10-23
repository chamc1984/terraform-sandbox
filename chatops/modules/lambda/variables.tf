variable "system_name" {
  description = "AWSリソース作成時のプレフィックスとなるシステム名"
  type        = string
}

variable "runtime" {
  description = "Lambdaランタイム"
  type        = string
}

variable "filename" {
  description = "Lambdaソースファイル"
  type        = string
}

variable "source_code_hash" {
  description = "ソースコード変更検知のためのハッシュ値"
  type        = string
}

variable "handler" {
  description = "Lambdaハンドラ"
  type        = string
}

variable "iam_role_arn" {
  description = "Lambda実行用IAMロールのARN"
  type        = string
}

variable "publish" {
  description = "バージョン発行するか否か"
  type        = bool
  default     = false
}

variable "memory_size" {
  description = "メモリサイズ（MB）"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "タイムアウト（秒）"
  type        = number
  default     = 3
}
