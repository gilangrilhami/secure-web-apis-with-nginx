variable "microsoft_entra_id_app_client_id" {
  type        = string
  description = "The client ID for the Microsoft Entra ID app."
}

variable "microsoft_entra_id_app_client_secret" {
  type        = string
  sensitive   = true
  description = "The client secret for the Microsoft Entra ID app."
}

variable "microsoft_azure_tenant_id" {
  type        = string
  description = "The tenant ID for the Microsoft Azure subscription."
}

variable "microsoft_azure_subscription_id" {
  type        = string
  description = "The subscription ID for the Microsoft Azure subscription."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "resource_group_location" {
  type        = string
  default     = "southeastasia"
  description = "The location of the resource group. Default is 'southeastasia'."
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account."
}

variable "acr_name" {
  type        = string
  description = "The name of the Azure Container Registry."
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "virtual_network_subnet_name" {
  type        = string
  default     = "default"
  description = "The name of the virtual network subnet. Default is 'default'."
}

variable "network_interface_name" {
  type        = string
  description = "The name of the network interface."
}

variable "network_security_group_name" {
  type        = string
  description = "The name of the network security group."
}

variable "network_interface_ip_conf_name" {
  type        = string
  default     = "ipconfig1"
  description = "The name of the network interface IP configuration. Default is 'ipconfig1'."
}

variable "virtual_machine_name" {
  type        = string
  description = "The name of the virtual machine."
}

variable "virtual_machine_admin_username" {
  type        = string
  description = "The admin username for the virtual machine."
}

variable "virtual_machine_admin_password" {
  type        = string
  sensitive   = true
  description = "The admin password for the virtual machine."
}

variable "public_ip_name" {
  type = string
  description = "The name for a VM's Public IP"
}