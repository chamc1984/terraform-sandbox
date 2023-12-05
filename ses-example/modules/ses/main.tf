# SES ドメイン認証
resource "aws_ses_domain_identity" "this" {
  domain = var.domain_name
}

# 検証トークンを"_amazonses.<DOMAIN>."のTXTレコードに登録
# https://docs.aws.amazon.com/ja_jp/ses/latest/dg/verify-addresses-and-domains.html
resource "aws_route53_record" "txt_example_com" {
  zone_id = var.zone_id
  name    = "_amazonses.${var.domain_name}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.this.verification_token]
}

# DKIM　の設定
resource "aws_ses_domain_dkim" "this" {
  domain = var.domain_name
}

# DKIM　を DNS の CNAME に登録
# resource "aws_ses_domain_dkim" を先に apply しないとリソースが読めない。一度コメントアウトで apply 実行してから再度 apply する。
resource "aws_route53_record" "cname_dkim_domain" {
  for_each = toset(aws_ses_domain_dkim.this.dkim_tokens)

  zone_id = var.zone_id
  name    = "${each.value}._domainkey.${var.domain_name}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${each.value}.dkim.amazonses.com"]
}

# カスタムMAIL-FROMドメインの設定
resource "aws_ses_domain_mail_from" "this" {
  domain = var.domain_name

  # mail_from_domain は domain のサブドメインにしないと以下のエラーになる
  # Error: setting MAIL FROM domain: InvalidParameterValue: Provided MAIL-FROM domain <***> is not subdomain of the domain of the identity <***>.
  mail_from_domain = "mail.${var.domain_name}"
}

# カスタムMAIL-FROMドメイン用のサブドメイン登録（mail.***）
resource "aws_route53_record" "mx_mail_domain" {
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.this.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.ap-northeast-1.amazonses.com"] # Ref https://docs.aws.amazon.com/ja_jp/ses/latest/DeveloperGuide/regions.html
}

# カスタムMAIL-FROMドメインのSPFレコード設定（TXTレコード：v=spf1 ***）
resource "aws_route53_record" "txt_mail_domain" {
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.this.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com ~all"]
}

# DMARC用のTXTレコードを登録（ここではnoneを選択）
resource "aws_route53_record" "txt_dmarc_domain" {
  zone_id = var.zone_id
  name    = "_dmarc.${var.domain_name}"
  type    = "TXT"
  ttl     = "600"
  records = ["v=DMARC1;p=none"] # Ref https://docs.aws.amazon.com/ja_jp/ses/latest/DeveloperGuide/send-email-authentication-dmarc.html
}
