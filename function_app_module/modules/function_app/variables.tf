variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "environment" { type = string }
variable "storage_account_tier" { type = string }
variable "storage_account_replication_type" { type = string }
variable "sku_tier" { type = string }
variable "sku_size" { type = string }
variable "dotnet_version" { type = string }
variable "function_extension_version" { type = string }
variable "worker_runtime" { type = string }
variable "tags" {
  type = map(string)
}