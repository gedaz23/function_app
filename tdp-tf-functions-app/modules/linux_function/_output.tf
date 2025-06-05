output "id" {
  description = "ID of the created Function App"
  value       = azurerm_linux_function_app.linux_function.id
}

output "name" {
  description = "Name of the created Function App"
  value       = azurerm_linux_function_app.linux_function.name
}

output "default_hostname" {
  description = "Default hostname of the created Function App"
  value       = azurerm_linux_function_app.linux_function.default_hostname
}

output "identity" {
  description = "Identity block output of the Function App"
  value       = try(azurerm_linux_function_app.linux_function.identity[0], null)
}

output "domain_verification_id" {
  description = "ID of the custom domain verification record"
  value       = azurerm_linux_function_app.linux_function.custom_domain_verification_id
}

output "slot_name" {
  description = "Name of the Function App slot"
  value       = try(azurerm_linux_function_app_slot.linux_function_slot[0].name, null)
}

output "slot_default_hostname" {
  description = "Default hostname of the Function App slot"
  value       = try(azurerm_linux_function_app_slot.linux_function_slot[0].default_hostname, null)
}

output "slot_identity" {
  description = "Identity block output of the Function App slot"
  value       = try(azurerm_linux_function_app_slot.linux_function_slot[0].identity[0], null)
}

output "slot_domain_verification_id" {
  description = "ID of the custom domain verification record"
  value       = try(azurerm_linux_function_app_slot.linux_function_slot[0].custom_domain_verification_id, null)
}
