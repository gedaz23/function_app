output "id" {
  value = local.function_app.id
}

output "name" {
  value = local.function_app.name
}

output "default_hostname" {
  value = local.function_app.default_hostname
}

output "fqdn" {
  value = try(trimsuffix(azurerm_dns_cname_record.app[0].fqdn, "."), null)
}

output "identity" {
  value = local.function_app.identity
}

output "slot_name" {
  value = local.function_app.slot_name
}

output "slot_default_hostname" {
  value = local.function_app.slot_default_hostname
}

output "slot_identity" {
  value = local.function_app.slot_identity
}

output "domain_verification_id" {
  value = local.function_app.domain_verification_id
}

output "slot_domain_verification_id" {
  value = local.function_app.slot_domain_verification_id
}

output "storage_account_name" {
  value = data.azurerm_storage_account.function_storage.name
}

output "storage_account_id" {
  value = data.azurerm_storage_account.function_storage.id
}

output "storage_account_identity" {
  value = data.azurerm_storage_account.function_storage.identity[0]
}

output "private_endpoint_ip_addresses_map" {
  description = "Map of private endpoint keys to their private IP addresses."
  value       = local.private_endpoint_ip_addresses_map
}
