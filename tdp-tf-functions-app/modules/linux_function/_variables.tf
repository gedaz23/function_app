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

variable "name" {
  type        = string
  description = "Name of the function app"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account"
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
  description = "Should the function app be enabled?"
  default     = true
}

variable "storage_uses_managed_identity" {
  type        = bool
  description = "Should the storage account use managed identity?"
  default     = true
}

variable "functions_extension_version" {
  type        = string
  description = "Version of the functions extension"
  default     = "~4"
}

variable "https_only" {
  type        = bool
  description = "Should the function app only accepts HTTPS requests?"
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Should public network access be enabled for the Function App? Defaults to `true`."
  default     = true
}

variable "slot_public_network_access_enabled" {
  type        = bool
  description = "Should public network access be enabled for the Function App slot? Defaults to `true`."
  default     = true
}
