variable "tenant_id" {
  type        = string
  default     = ""
  description = "Tenant Id"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "grant_admin_consent" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from granting admin consent"
}
