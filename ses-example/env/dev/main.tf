module "ses" {
  source      = "../../modules/ses"
  domain_name = var.domain_name
  zone_id     = var.zone_id
}
