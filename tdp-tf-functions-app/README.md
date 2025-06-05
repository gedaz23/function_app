# A Terraform module for tdp-tf-functions-app

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.116.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.91.0 |
## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_custom_hostname_binding.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding) | resource |
| [azurerm_dns_cname_record.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_txt_record.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_private_dns_cname_record.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_endpoint.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.app_slot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_queue.app_queues](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_account.function_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_restrictions"></a> [access\_restrictions](#input\_access\_restrictions) | Access restrictions for the function app | <pre>list(object({<br>    name       = string<br>    priority   = string<br>    action     = string<br>    ip_address = string<br>    subnet     = string<br>  }))</pre> | `[]` | no |
| <a name="input_always_on"></a> [always\_on](#input\_always\_on) | Whether the function app is always on | `bool` | `true` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | Application setting | `map(string)` | `{}` | no |
| <a name="input_application_insights_key"></a> [application\_insights\_key](#input\_application\_insights\_key) | Key of the application insights | `string` | `""` | no |
| <a name="input_application_stack"></a> [application\_stack](#input\_application\_stack) | Technology stack of the function app, e.g. `Python` or `Node` | `string` | `"Python"` | no |
| <a name="input_assign_contributor_role"></a> [assign\_contributor\_role](#input\_assign\_contributor\_role) | Assign contributor role to the function app | `bool` | `true` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | Custom Domain parameters:<pre>  - dns_record_name:                 Name of the DNS record.<br>  - dns_zone_resource_group_name:    Resource group where the DNS Zone exists.<br>  - certificate_thumbprint:          Thumbprint of the SSL certificate for binding.<br>  - public_dns_zone_name:            Public DNS Zone name.<br>  - private_dns_zone_name:           Optional Private DNS Zone name (for private CNAME/A).<br>  - private_dns_record_type:       Optional type of private DNS record ('A' or 'CNAME'). Defaults to 'A'.<br>  - create_hub_pdns_record:        Optional flag (defaults to false). If true and type is 'A', creates Hub A record for 'internal' PE.</pre> | <pre>object({<br>    dns_record_name              = string<br>    dns_zone_resource_group_name = string<br>    certificate_thumbprint       = string<br>    public_dns_zone_name         = string<br>    private_dns_zone_name        = optional(string)<br>    create_hub_pdns_record       = optional(bool, false)<br>    private_dns_record_type      = optional(string, "A") 
  })</pre> | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the function app is enabled | `bool` | `true` | no |
| <a name="input_functions_extension_version"></a> [functions\_extension\_version](#input\_functions\_extension\_version) | Version of the functions extension | `string` | `"~4"` | no |
| <a name="input_health_check_eviction_time_in_min"></a> [health\_check\_eviction\_time\_in\_min](#input\_health\_check\_eviction\_time\_in\_min) | Eviction time in minutes for the health check | `number` | `5` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | Path for the health check | `string` | `"/health/api/ping"` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | Whether the function app only accepts HTTPS requests | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the resource group | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the function app | `string` | n/a | yes |
| <a name="input_node_version"></a> [node\_version](#input\_node\_version) | Version of Node | `string` | `"20"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | <pre>The os_type indicates the Operating System type for this function app. Possible values are `linux` or `windows`.<br>  This value will be linux for Linux derivatives, or windows for Windows. When set to linux you must also set azurerm_app_service_plan arguments as os_type = "Linux"</pre> | `string` | `"linux"` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Private Endpoint parameters:<pre>- private_subnet_id:              The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint.<br>  - privatelink_dns_zone_id:        Specifies the Private DNS Zone to include within the private_dns_zone_group for the private link service.</pre> | <pre>map(object({<br>    private_subnet_id       = string<br>    privatelink_dns_zone_id = string<br>  }))</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Should public network access be enabled for the Function App. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_python_version"></a> [python\_version](#input\_python\_version) | Version of Python | `string` | `"3.11"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_scm_use_main_ip_restriction"></a> [scm\_use\_main\_ip\_restriction](#input\_scm\_use\_main\_ip\_restriction) | Whether the function app SCM uses the main IP restriction | `bool` | `true` | no |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | ID of the service plan | `string` | n/a | yes |
| <a name="input_slot_app_settings"></a> [slot\_app\_settings](#input\_slot\_app\_settings) | Application setting for the slot. Default to app\_settings if not provided. | `map(string)` | `null` | no |
| <a name="input_slot_enabled"></a> [slot\_enabled](#input\_slot\_enabled) | should the app slot be enabled? This is only applicable when `slot_name` is not `null`. | `bool` | `true` | no |
| <a name="input_slot_name"></a> [slot\_name](#input\_slot\_name) | Name of the slot, set it to `null` if you don't want to use slots. Default is `staging`. | `string` | `"staging"` | no |
| <a name="input_slot_public_network_access_enabled"></a> [slot\_public\_network\_access\_enabled](#input\_slot\_public\_network\_access\_enabled) | Should public network access be enabled for the Function App slot. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_slot_scm_use_main_ip_restriction"></a> [slot\_scm\_use\_main\_ip\_restriction](#input\_slot\_scm\_use\_main\_ip\_restriction) | Whether the function app slot SCM uses the main IP restriction | `bool` | `false` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The backend storage account name which will be used by this Function App. | `string` | n/a | yes |
| <a name="input_storage_containers"></a> [storage\_containers](#input\_storage\_containers) | Storage containers to create and their access levels in the storage account. | <pre>map(object({<br>    name                  = string<br>    container_access_type = optional(string, "private")<br>  }))</pre> | `{}` | no |
| <a name="input_storage_network_rules"></a> [storage\_network\_rules](#input\_storage\_network\_rules) | Network rules to apply to storage account. | <pre>object({<br>    bypass                     = optional(list(string), ["None"])<br>    default_action             = optional(string, "Deny")<br>    ip_rules                   = optional(list(string))<br>    virtual_network_subnet_ids = optional(list(string))<br>    private_link_accesses = optional(list(object({<br>      endpoint_resource_id = string<br>      endpoint_tenant_id   = optional(string, null)<br>    })), [])<br>  })</pre> | `{}` | no |
| <a name="input_storage_queues"></a> [storage\_queues](#input\_storage\_queues) | Storage Queues to create in the storage account. | <pre>map(object({<br>    name = string<br>  }))</pre> | `{}` | no |
| <a name="input_storage_resource_group_name"></a> [storage\_resource\_group\_name](#input\_storage\_resource\_group\_name) | The backend storage account's resource group name which will be used by this Function App. Defaults to the resource group of the Function App. | `string` | `null` | no |
| <a name="input_storage_uses_managed_identity"></a> [storage\_uses\_managed\_identity](#input\_storage\_uses\_managed\_identity) | Whether the storage account uses managed identity | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources created. | `map(string)` | n/a | yes |
| <a name="input_tf_infra"></a> [tf\_infra](#input\_tf\_infra) | Common infrastructure object containing values from the tf-infra-setup project. Required by the tdp-tf-pdns-a-record module when private\_dns\_record\_type is 'A'. | <pre>object({<br>    keyvault_id = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_use_32_bit_worker"></a> [use\_32\_bit\_worker](#input\_use\_32\_bit\_worker) | Whether the function app uses a 32-bit worker | `bool` | `false` | no |
| <a name="input_use_existing_storage_account"></a> [use\_existing\_storage\_account](#input\_use\_existing\_storage\_account) | Whether existing Storage Account should be used instead of creating a new one. | `bool` | `false` | no |
| <a name="input_use_slot"></a> [use\_slot](#input\_use\_slot) | Should the function app use a slot? | `bool` | `true` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual\_network\_subnet\_id](#input\_virtual\_network\_subnet\_id) | The subnet id which will be used by this Function App for regional virtual network integration. | `string` | `null` | no |
| <a name="input_vnet_route_all_enabled"></a> [vnet\_route\_all\_enabled](#input\_vnet\_route\_all\_enabled) | Whether the function app routes all traffic through the virtual network | `bool` | `true` | no |
| <a name="input_website_contributor_id"></a> [website\_contributor\_id](#input\_website\_contributor\_id) | principal id of the Function app contributor | `string` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | n/a |
| <a name="output_domain_verification_id"></a> [domain\_verification\_id](#output\_domain\_verification\_id) | n/a |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_identity"></a> [identity](#output\_identity) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_slot_default_hostname"></a> [slot\_default\_hostname](#output\_slot\_default\_hostname) | n/a |
| <a name="output_slot_domain_verification_id"></a> [slot\_domain\_verification\_id](#output\_slot\_domain\_verification\_id) | n/a |
| <a name="output_slot_identity"></a> [slot\_identity](#output\_slot\_identity) | n/a |
| <a name="output_slot_name"></a> [slot\_name](#output\_slot\_name) | n/a |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | n/a |
| <a name="output_storage_account_identity"></a> [storage\_account\_identity](#output\_storage\_account\_identity) | n/a |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | n/a |
| <a name="output_private_endpoint_ip_addresses_map"></a> [private\_endpoint\_ip\_addresses\_map](#output\_private\_endpoint\_ip\_addresses\_map) | Map of private endpoint keys to their private IP addresses. |

## Examples
Module usage:

```hcl
module "stream_function_apps" {
  for_each = { for source in var.source_systems : source.name => source }
  source   = "git::https://dev.azure.com/tietodata/terraform-modules/_git/tdp-tf-functions-app?ref=1.1.0"

  name                = "${local.prefix}-${each.key}"
  service_plan_id     = module.stream_service_plan.plan_id
  resource_group_name = azurerm_resource_group.default.name
  location            = var.location

  use_existing_storage_account = true
  storage_account_name         = lower(replace("${local.prefix}${each.key}", "-", ""))

  application_stack                  = "Python"
  application_insights_key           = azurerm_application_insights.default.instrumentation_key
  access_restrictions                = local.stream_apps.function_access_restrictions
  virtual_network_subnet_id          = local.core.subnets.functions.id
  public_network_access_enabled      = var.public_network_access_enabled
  slot_public_network_access_enabled = false

  app_settings = merge({
    VERSION                      = var.stream_data_int_version,
    SOURCE_SYSTEM                = lower(each.key),
    APP_CONFIGURATION_NAME       = azurerm_app_configuration.default.name,
    APP_CONFIGURATION_FILTER_KEY = "${local.configuration_prefix}:",
  }, each.value.app_settings)

  private_endpoints = {
    for k, v in local.private_endpoints.functionApp :
    k => {
      private_subnet_id       = v.subnet_id
      privatelink_dns_zone_id = v.dns_zones["webApp"].id
    }
    if try(contains(keys(v), "dns_zones"), false) && contains(keys(v.dns_zones), "webApp")
  }

  custom_domain = {
    enabled                      = true
    dns_record_name              = "stream-${each.key}"
    dns_zone_resource_group_name = local.core.dns_zones.resource_group.name
    certificate_thumbprint       = azurerm_app_service_certificate.ssl_certificate_import.thumbprint
    public_dns_zone_name         = local.core.dns_zones.public.name
    private_dns_zone_name        = local.core.dns_zones.private.name
    private_dns_record_type      = "A"
    create_hub_pdns_record       = each.value.create_hub_pdns_record
  }

  tf_infra                       = local.tf_infra

  website_contributor_id = azuread_group.application_deployer.object_id
  tags                   = local.application_tags

  depends_on = [module.stream_service_plan, module.function_storage]
}
```
