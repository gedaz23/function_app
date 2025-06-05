output "function_app_name" {
  value = azurerm_linux_function_app.main.name
}

output "function_app_default_hostname" {
  value = azurerm_linux_function_app.main.default_hostname
}

output "app_insights_key" {
  value = azurerm_application_insights.main.instrumentation_key
}