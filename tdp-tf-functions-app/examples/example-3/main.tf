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
  storage_containers = {
    data  = { name = "stream-data" }
    event = { name = "stream-event" }
  }
  storage_queues = {
    stream        = { name = "stream-event" }
    stream_poison = { name = "stream-event-poison" }
    batch         = { name = "stream-batch" }
    batch_poison  = { name = "stream-batch-poison" }
  }

  app_settings = {
    SOURCE_SYSTEM = "lifecare",
    APP_VERSION   = "1.0.0",
  }

  website_contributor_id = azuread_group.application_deployer.object_id
  tags                   = local.application_tags

  depends_on = [module.stream_service_plan]
}
