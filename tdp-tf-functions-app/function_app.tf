module "linux_function" {
  for_each = toset(lower(var.os_type) == "linux" ? ["enabled"] : [])

  source = "./modules/linux_function"

  name                = var.name
  service_plan_id     = var.service_plan_id
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name               = data.azurerm_storage_account.function_storage.name
  use_slot                           = var.use_slot
  slot_enabled                       = var.slot_enabled
  slot_name                          = var.slot_name
  virtual_network_subnet_id          = var.virtual_network_subnet_id
  enabled                            = var.enabled
  storage_uses_managed_identity      = var.storage_uses_managed_identity
  functions_extension_version        = var.functions_extension_version
  https_only                         = var.https_only
  public_network_access_enabled      = var.public_network_access_enabled
  slot_public_network_access_enabled = var.slot_public_network_access_enabled
  app_settings                       = var.app_settings
  slot_app_settings                  = var.slot_app_settings
  application_insights_key           = var.application_insights_key
  health_check_path                  = var.health_check_path
  access_restrictions                = var.access_restrictions
  always_on                          = var.always_on
  use_32_bit_worker                  = var.use_32_bit_worker
  vnet_route_all_enabled             = var.vnet_route_all_enabled
  health_check_eviction_time_in_min  = var.health_check_eviction_time_in_min
  scm_use_main_ip_restriction        = var.scm_use_main_ip_restriction
  slot_scm_use_main_ip_restriction   = var.slot_scm_use_main_ip_restriction
  application_stack                  = var.application_stack
  python_version                     = var.python_version
  node_version                       = var.node_version

  assign_contributor_role = var.assign_contributor_role
  website_contributor_id  = var.website_contributor_id
  tags                    = var.tags
}

### Windows Function App Placeholder
### will be implemented in the future
module "windows_function" {
  for_each = toset(lower(var.os_type) == "windows" ? ["enabled"] : [])

  source = "./modules/windows_function"
}
