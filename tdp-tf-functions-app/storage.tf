module "function_storage" {
  for_each = toset(var.use_existing_storage_account ? [] : ["enabled"])

  source = "git::https://dev.azure.com/tietodata/terraform-modules/_git/tdp-tf-storage-account?ref=v1.5.0"

  name                = local.storage_account_name
  resource_group_name = coalesce(var.storage_resource_group_name, var.resource_group_name)
  location            = var.location

  is_hns_enabled = true
  containers     = var.storage_containers

  network_rules     = var.storage_network_rules
  diagnostic_create = false

  tags = local.storage_tags
}

data "azurerm_storage_account" "function_storage" {
  name                = local.storage_account_name
  resource_group_name = coalesce(var.storage_resource_group_name, var.resource_group_name)

  depends_on = [module.function_storage]
}


resource "azurerm_storage_queue" "app_queues" {
  for_each = var.storage_queues

  name                 = each.value.name
  storage_account_name = data.azurerm_storage_account.function_storage.name
}
