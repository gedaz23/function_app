resource "azurerm_linux_function_app_slot" "linux_function_slot" {
  count = var.use_slot ? 1 : 0

  name            = lower(var.slot_name)
  function_app_id = azurerm_linux_function_app.linux_function.id
  enabled         = var.slot_enabled

  storage_account_name          = lower(var.storage_account_name)
  storage_uses_managed_identity = var.storage_uses_managed_identity
  functions_extension_version   = var.functions_extension_version
  https_only                    = var.https_only
  virtual_network_subnet_id     = var.virtual_network_subnet_id
  public_network_access_enabled = var.slot_public_network_access_enabled
  app_settings                  = merge(local.app_settings, coalesce(var.slot_app_settings, var.app_settings))

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                         = var.always_on
    application_insights_key          = var.application_insights_key
    health_check_path                 = var.health_check_path
    health_check_eviction_time_in_min = var.health_check_eviction_time_in_min
    use_32_bit_worker                 = var.use_32_bit_worker
    vnet_route_all_enabled            = var.vnet_route_all_enabled
    scm_use_main_ip_restriction       = var.slot_scm_use_main_ip_restriction

    dynamic "application_stack" {
      for_each = lower(var.application_stack) == "python" ? [1] : []
      content {
        python_version = var.python_version
      }
    }
    dynamic "application_stack" {
      for_each = lower(var.application_stack) == "node" ? [1] : []
      content {
        node_version = var.node_version
      }
    }

    dynamic "ip_restriction" {
      for_each = { for restriction in var.access_restrictions : restriction.name => restriction }

      content {
        name = ip_restriction.key

        priority                  = ip_restriction.value.priority
        action                    = ip_restriction.value.action
        ip_address                = ip_restriction.value.ip_address
        virtual_network_subnet_id = ip_restriction.value.subnet
      }
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags,
      app_settings["APP_VERSION"],
      app_settings["AzureWebJobsDashboard__accountName"],
      app_settings["WEBSITE_HEALTHCHECK_MAXPINGFAILURES"],
      app_settings["WEBSITES_ENABLE_APP_SERVICE_STORAGE"]
    ]
  }
}

resource "azurerm_role_assignment" "function_app_slot_website_contributor" {
  count = var.assign_contributor_role && var.use_slot ? 1 : 0

  scope                = azurerm_linux_function_app_slot.linux_function_slot[0].id
  role_definition_name = "Website Contributor"
  principal_id         = var.website_contributor_id
}
