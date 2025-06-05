###########################################################
##            PRIVATE ENDPOINT - Function-APP
###########################################################

resource "azurerm_private_endpoint" "app" {
  for_each = { for k, v in coalesce(var.private_endpoints, {}) : k => v }

  name                = "${local.function_app.name}-${each.key}-pe"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = each.value.private_subnet_id

  private_service_connection {
    name                           = "${local.function_app.name}-${each.key}-pc"
    private_connection_resource_id = local.function_app.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "${local.function_app.name}-dns-zone-group"
    private_dns_zone_ids = [each.value.privatelink_dns_zone_id]
  }

  tags = local.private_endpoint_tags

  depends_on = [local.function_app]
}

###########################################################
##        PRIVATE ENDPOINT - Function-APP Slot
###########################################################

resource "azurerm_private_endpoint" "app_slot" {
  for_each = { for k, v in coalesce(var.private_endpoints, {}) : k => v if var.slot_name != null }

  name                = "${local.function_app.name}-${var.slot_name}-${each.key}-pe"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = each.value.private_subnet_id


  private_service_connection {
    name                           = "${local.function_app.name}-${var.slot_name}-${each.key}-pc"
    private_connection_resource_id = local.function_app.id
    subresource_names              = ["sites-${var.slot_name}"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "${local.function_app.name}-${var.slot_name}-dns-zone-group"
    private_dns_zone_ids = [each.value.privatelink_dns_zone_id]
  }

  tags = local.private_endpoint_tags

  depends_on = [local.function_app]
}
