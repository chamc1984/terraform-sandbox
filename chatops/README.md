# chatops

## 概要

Slack -> ChatBot -> Lambda -> EC2 の起動停止

## 実行方法

Slack で以下のコマンドを実行。Reply が来るので `[Run] command` を押下。

```txt
### Status確認
@aws lambda invoke --payload {"Action": "describe", "Tag": "EC2のタグ名"} --function-name chatops-function

### 起動
@aws lambda invoke --payload {"Action": "Start", "Tag": "EC2のタグ名"} --function-name chatops-function

### 停止
@aws lambda invoke --payload {"Action": "Stop", "Tag": "EC2のタグ名"} --function-name chatops-function
```

alias 設定しておくと楽。

詳細は[公式](https://docs.aws.amazon.com/chatbot/latest/adminguide/creating-aliases.html)

```txt
### alias設定
@aws alias create desc lambda invoke --payload {"Action": "describe", "Tag": "EC2のタグ名"} --function-name chatops-function --region ap-northeast-1

### 実行
@aws run desc

### alias 一覧
@aws alias list
```

## 前提

ChatBot と Slack の Authorize は事前にマネジメントコンソールで行っておく

slack の ID など、機密情報は GitHub にあげられないので `terraform.tfvars` を用意して実行すること。

```hcl
# サンプル
slack_workspace_id = "xxx"   # SlackのワークスペースID
slack_channel_id   = "xxx" # SlackのチャンネルID
```

- workspace_id は、 `https://xxx.slack.com` をブラウザで開くと見れる
- channel_id は、 Slack で該当のチャンネルの詳細を開くと見れる

## Lambda のローカル実行

[lambci](https://github.com/lambci/docker-lambda)

```sh
docker run --rm -v "$PWD":/var/task:ro,delegated \
lambci/lambda:python3.8 lambda_function.lambda_handler
```
