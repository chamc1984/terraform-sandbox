# zipファイルを一時生成。buildディレクトリ以下は存在しなければ自動生成されるのでgitignoreしておく。
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "../../lambda"
  output_path = "build/lambda/function.zip"
}
