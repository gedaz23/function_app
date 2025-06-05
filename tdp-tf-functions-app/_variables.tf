variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the resource group"
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
}

variable "assign_contributor_role" {
  description = "Assign contributor role to the function app"
  type        = bool
  default     = true
}

variable "website_contributor_id" {
  description = "principal id of the Function app contributor"
  type        = string
  default     = null
}

# function app configuration
variable "application_insights_key" {
  type        = string
  description = "Key of the application insights"
  default     = ""
}

variable "health_check_path" {
  type        = string
  description = "Path for the health check"
  default     = "/health/api/ping"
}

variable "access_restrictions" {
  type = list(object({
    name       = string
    priority   = string
    action     = string
    ip_address = string
    subnet     = string
  }))
  description = "Access restrictions for the function app"
  default     = []
}

variable "app_settings" {
  type        = map(string)
  description = "Application setting"
  default     = {}
}

variable "slot_app_settings" {
  type        = map(string)
  description = "Application setting for the slot. Default to app_settings if not provided."
  default     = null
}

variable "always_on" {
  type        = bool
  description = "Whether the function app is always on"
  default     = true
}

variable "health_check_eviction_time_in_min" {
  type        = number
  description = "Eviction time in minutes for the health check"
  default     = 5
}

variable "use_32_bit_worker" {
  type        = bool
  description = "Whether the function app uses a 32-bit worker"
  default     = false
}

variable "vnet_route_all_enabled" {
  type        = bool
  description = "Whether the function app routes all traffic through the virtual network"
  default     = true
}

variable "scm_use_main_ip_restriction" {
  type        = bool
  description = "Whether the function app SCM uses the main IP restriction"
  default     = true
}

variable "slot_scm_use_main_ip_restriction" {
  type        = bool
  description = "Whether the function app slot SCM uses the main IP restriction"
  default     = false
}

variable "application_stack" {
  type        = string
  description = "Technology stack of the function app, e.g. `Python` or `Node`"
  validation {
    condition     = try(contains(["python", "node"], lower(var.application_stack)), true)
    error_message = "The `application_stack` value must be valid. Possible values are `Python` and `Node`."
  }
  default = "Python"
}

variable "python_version" {
  type        = string
  description = "Version of Python"
  default     = "3.11"
}

variable "node_version" {
  type        = string
  description = "Version of Node"
  default     = "20"
}

variable "name" {
  type        = string
  description = "Name of the function app"
}

variable "os_type" {
  type        = string
  description = <<EOD
  ```
  The os_type indicates the Operating System type for this function app. Possible values are `linux` or `windows`.
  This value will be linux for Linux derivatives, or windows for Windows. When set to linux you must also set azurerm_app_service_plan arguments as os_type = "Linux"
  ```
  EOD
  validation {
    condition     = try(contains(["linux"], lower(var.os_type)), true)
    error_message = "The `os_type` value must be linux. Possible value for now is only `linux`."
  }
  default = "linux"
}

variable "service_plan_id" {
  type        = string
  description = "ID of the service plan"
}

variable "use_slot" {
  type        = bool
  description = "Should the function app use a slot?"
  default     = true
}

variable "slot_enabled" {
  type        = bool
  description = "should the app slot be enabled? This is only applicable when `slot_name` is not `null`."
  default     = true
}

variable "slot_name" {
  type        = string
  description = "Name of the slot, set it to `null` if you don't want to use slots. Default is `staging`."
  default     = "staging"
}

variable "virtual_network_subnet_id" {
  type        = string
  description = "The subnet id which will be used by this Function App for regional virtual network integration."
  default     = null
}

variable "enabled" {
  type        = bool
  description = "Whether the function app is enabled"
  default     = true
}

variable "storage_uses_managed_identity" {
  type        = bool
  description = "Whether the storage account uses managed identity"
  default     = true
}

variable "functions_extension_version" {
  type        = string
  description = "Version of the functions extension"
  default     = "~4"
}

variable "https_only" {
  type        = bool
  description = "Whether the function app only accepts HTTPS requests"
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Should public network access be enabled for the Function App. Defaults to `true`."
  default     = true
}

variable "slot_public_network_access_enabled" {
  type        = bool
  description = "Should public network access be enabled for the Function App slot. Defaults to `true`."
  default     = true
}

# Storage Account settings
variable "use_existing_storage_account" {
  description = "Whether existing Storage Account should be used instead of creating a new one."
  type        = bool
  default     = false
}

variable "storage_account_name" {
  type        = string
  description = "The backend storage account name which will be used by this Function App."
}

variable "storage_resource_group_name" {
  type        = string
  description = "The backend storage account's resource group name which will be used by this Function App. Defaults to the resource group of the Function App."
  default     = null
}

variable "storage_network_rules" {
  description = "Network rules to apply to storage account."
  type = object({
    bypass                     = optional(list(string), ["None"])
    default_action             = optional(string, "Deny")
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
    private_link_accesses = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string, null)
    })), [])
  })
  default = {}
}

variable "storage_containers" {
  description = "Storage containers to create and their access levels in the storage account."
  type = map(object({
    name                  = string
    container_access_type = optional(string, "private")
  }))
  default = {}
}

variable "storage_queues" {
  description = "Storage Queues to create in the storage account."
  type = map(object({
    name = string
  }))
  default = {}
}

# Networking
variable "custom_domain" {
  description = <<EOD
  Custom Domain parameters:
  ```
  - dns_record_name:                 Specifies the name of the DNS CNAME record.
  - dns_zone_resource_group_name:    Specifies the resource group where the resource exists.
  - certificate_thumbprint:          Specifies the thumbprint of the SSL certificate used for secure DNS.
  - public_dns_zone_name:            Specifies the Public DNS Zone where the resource exists.
  - private_dns_zone_name:           Specifies the Optional Private DNS Zone where the resource exists.
  ```
  EOD
  type = object({
    dns_record_name              = string
    dns_zone_resource_group_name = string
    certificate_thumbprint       = string
    public_dns_zone_name         = string
    private_dns_zone_name        = optional(string)
    create_hub_pdns_record       = optional(bool, false)
    private_dns_record_type      = optional(string, "A")
  })
  default = null
}

variable "private_endpoints" {
  description = <<EOD
  Private Endpoint parameters:
  ```
  - private_subnet_id:              The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint.
  - privatelink_dns_zone_id:        Specifies the Private DNS Zone to include within the private_dns_zone_group for the private link service.
  ```
  EOD
  type = map(object({
    private_subnet_id       = string
    privatelink_dns_zone_id = string
  }))
  default = null
}

variable "tf_infra" {
  type = object({ 
    keyvault_id = optional(string)
  })
  description = "Common infrastructure object containing values from the tf-infra-setup project. Required by the tdp-tf-pdns-a-record module when private_dns_record_type is 'A'."
  default     = null
}