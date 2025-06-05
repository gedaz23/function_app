locals {
  storage_account_name  = lower(replace(var.storage_account_name, "-", ""))
  storage_tags          = merge(var.tags, { usage = "Data Platform Streaming Integration Storage account" })
  private_endpoint_tags = merge(var.tags, { usage = "Data Platform Streaming Integration Private Endpoint" })
  function_app          = try(module.linux_function["enabled"], module.windows_function["enabled"])

  # private_endpoint_ip_addresses_map: stores a mapping of private endpoint keys to their private IP addresses
  # filters out endpoints that are null, have no service connection, or no IP address.
  private_endpoint_ip_addresses_map = {
    for k, pe in azurerm_private_endpoint.app : k => pe.private_service_connection[0].private_ip_address
    if pe != null && length(try(pe.private_service_connection, [])) > 0 && try(pe.private_service_connection[0].private_ip_address, null) != null
  }
}
