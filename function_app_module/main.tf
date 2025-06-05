module "function_app" {
  source                    = "./modules/function_app"
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  environment               = var.environment
  storage_account_tier      = var.storage_account_tier
  storage_account_replication_type = var.storage_account_replication_type
  sku_tier                  = var.sku_tier
  sku_size                  = var.sku_size
  dotnet_version            = var.dotnet_version
  function_extension_version = var.function_extension_version
  worker_runtime            = var.worker_runtime
  tags                      = var.tags
}