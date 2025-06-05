module "stream_function_apps" {
  source = "git::https://dev.azure.com/tietodata/terraform-modules/_git/tdp-tf-functions-app?ref=1.1.0"

  name                = "${var.prefix}-stream-function"
  service_plan_id     = var.service_plan_id
  resource_group_name = azurerm_resource_group.default.name
  location            = var.location

  application_stack         = "Node"
  node_version              = "18"
  use_existing_storage_account = true
  storage_account_name      = "${var.prefix}streamstorage"
  virtual_network_subnet_id = var.functions_subnet_id

  app_settings = {
    SOURCE_SYSTEM = "lifecare",
    APP_VERSION   = "1.0.0",
  }

  website_contributor_id = azuread_group.application_deployer.object_id
  tags                   = local.application_tags

}
