resource "azurerm_storage_account" "main" {
  name                     = lower(replace("${var.name}${var.environment}", "-", ""))
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  kind                     = "StorageV2"
  tags                     = var.tags
}