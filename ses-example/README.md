# ses-sample

AWS SES をセットアップして、Route53 を使って SPF/DKIM/DMARC まで設定する。

実ドメインは GitHub にはあげたくないので、terraform.tfvars で差し込む。

```ini
#terraform.tfvars
domain_name = "xxx" #メール送信元とするドメイン名.SESの検証IDともなる
zone_id     = "xxx" #DNSのゾーンID
```
