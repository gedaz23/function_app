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
