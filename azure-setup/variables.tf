variable "microsoft_entra_id_app_client_id" {
  type = string
}

variable "microsoft_entra_id_app_client_secret" {
  type = string
  sensitive = true
}

variable "microsoft_azure_tenant_id" {
  type = string
}

variable "microsoft_azure_subscription_id" {
  type = string
}

variable "resource_group_name" {
  type    = string
}

variable "resource_group_location" {
  type    = string
  default = "southeastasia"
}

variable "storage_account_name" {
  type    = string
}

variable "acr_name" {
  type    = string
}

variable "virtual_network_name" {
  type    = string
}

variable "virtual_network_subnet_name" {
  type    = string
  default = "default"
}

variable "network_interface_name" {
  type    = string
}

variable "network_interface_ip_conf_name" {
  type    = string
  default = "ipconfig1"
}

variable "virtual_machine_name" {
  type    = string
}

variable "virtual_machine_admin_username" {
  type    = string
}

variable "virtual_machine_admin_password" {
  type      = string
  sensitive = true
}
