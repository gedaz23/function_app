###########################################################
##             PUBLIC DNS RECORD: Function APP
###########################################################
resource "azurerm_dns_txt_record" "app" {
  count = var.custom_domain != null ? 1 : 0

  name                = "asuid.${var.custom_domain.dns_record_name}"
  zone_name           = var.custom_domain.public_dns_zone_name
  resource_group_name = var.custom_domain.dns_zone_resource_group_name

  ttl = 300

  record {
    value = local.function_app.domain_verification_id
  }

  depends_on = [local.function_app]
}

resource "azurerm_dns_cname_record" "app" {
  count = var.custom_domain != null ? 1 : 0

  name                = var.custom_domain.dns_record_name
  zone_name           = var.custom_domain.public_dns_zone_name
  record              = local.function_app.default_hostname
  resource_group_name = var.custom_domain.dns_zone_resource_group_name

  ttl = 300

  depends_on = [azurerm_dns_txt_record.app]
}


###########################################################
##           PRIVATE DNS CNAME RECORD: Function APP
###########################################################

resource "azurerm_private_dns_cname_record" "app" {
  count = var.custom_domain.private_dns_record_type == "CNAME" ? 1 : 0

  name                = var.custom_domain.dns_record_name
  zone_name           = var.custom_domain.private_dns_zone_name
  record              = local.function_app.default_hostname
  resource_group_name = var.custom_domain.dns_zone_resource_group_name 
  ttl                 = 300
  tags                = var.tags

  depends_on = [azurerm_dns_txt_record.app]
}

###########################################################
##     PRIVATE DNS A RECORD MODULE CALL (Per PE): Function APP
###########################################################

module "private_dns_a_records" {
  for_each = var.custom_domain.private_dns_record_type == "A" ? {
    for k, ip in local.private_endpoint_ip_addresses_map : k => ip if k == "internal"
  } : {}

  source = "git::https://dev.azure.com/tietodata/terraform-modules/_git/tdp-tf-pdns-a-record?ref=v1.0.0"

  tf_infra            = var.tf_infra 
  name                = var.custom_domain.dns_record_name 
  resource_group_name = var.custom_domain.dns_zone_resource_group_name 
  zone_name           = var.custom_domain.private_dns_zone_name
  records             = [each.value]
  tags                = var.tags 

  create_hub_pdns_a_record = var.custom_domain.create_hub_pdns_record && each.key == "internal"
}


###########################################################
##           CUSTOM HOSTNAME BINDING: Function APP
###########################################################
resource "azurerm_app_service_custom_hostname_binding" "app" {
  count = var.custom_domain != null ? 1 : 0

  hostname            = trimsuffix(azurerm_dns_cname_record.app[0].fqdn, ".") 
  app_service_name    = local.function_app.name
  resource_group_name = var.resource_group_name
  ssl_state           = "SniEnabled"
  thumbprint          = var.custom_domain.certificate_thumbprint

  depends_on = [azurerm_dns_txt_record.app, azurerm_dns_cname_record.app]
}
