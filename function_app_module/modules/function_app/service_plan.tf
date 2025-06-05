resource "azurerm_app_service_plan" "main" {
  name                = "${var.name}-plan-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "FunctionApp"
  reserved            = true

  sku {
    tier = var.sku_tier
    size = var.sku_size
  }

  tags = var.tags
}