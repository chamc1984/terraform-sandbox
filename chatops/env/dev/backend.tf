terraform {
  ### 実運用上はS3にtfstateファイルを置くべき
  # backend "s3" {
  #   bucket                  = "{バケット名}"
  #   key                     = "{tfstateファイル名}.tfstate"
  #   region                  = "ap-northeast-1"
  #   shared_credentials_file = "~/.aws/credentials"
  #   profile                 = "default"
  #   encrypt                 = true
  # }
  backend "local" {
    path = "chatops.tfstate"
  }
}
