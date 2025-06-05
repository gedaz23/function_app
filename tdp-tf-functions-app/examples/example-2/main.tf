module "stream_function_apps" {
  source = "git::https://dev.azure.com/tietodata/terraform-modules/_git/tdp-tf-functions-app?ref=1.1.0"

  name                = "${var.prefix}-stream-function"
  service_plan_id     = module.stream_service_plan.plan_id
  resource_group_name = azurerm_resource_group.default.name
  location            = var.location

  application_stack         = "Python"
  use_existing_storage_account = true
  storage_account_name      = "${var.prefix}streamstorage"
  virtual_network_subnet_id = var.functions_subnet_id
  application_insights_key  = var.instrumentation_key

  storage_network_rules = {
    virtual_network_subnet_ids = [
      var.TF_SUBNET_ID,
      var.functions_subnet_id
    ]
  }
  private_endpoints = {
    default = {
      private_subnet_id       = var.private_subnet_id
      privatelink_dns_zone_id = azurerm_private_dns_zone.privatelink_azurewebsites.id
    }
  }

  custom_domain = {
    dns_record_name              = "stream-function"
    dns_zone_resource_group_name = var.dns_zones_resource_group_name
    certificate_thumbprint       = azurerm_app_service_certificate.ssl_certificate_import.thumbprint
    public_dns_zone_name         = local.dns_zones_public_name
    private_dns_zone_name        = local.dns_zones_private_name
    private_dns_record_type      = "A"
  }

  website_contributor_id = azuread_group.application_deployer.object_id
  tags                   = local.application_tags

  depends_on = [module.stream_service_plan]
}
