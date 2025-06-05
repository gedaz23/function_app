resource "azurerm_linux_function_app" "main" {
  name                       = "${var.name}-func-${var.environment}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = azurerm_app_service_plan.main.id
  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key

  site_config {
    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.main.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.main.connection_string
    "AzureWebJobsStorage"                   = azurerm_storage_account.main.primary_connection_string
    "FUNCTIONS_EXTENSION_VERSION"           = var.function_extension_version
    "FUNCTIONS_WORKER_RUNTIME"              = var.worker_runtime
    "WEBSITE_RUN_FROM_PACKAGE"              = "1"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}