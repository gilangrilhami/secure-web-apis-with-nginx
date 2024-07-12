provider "azurerm" {
  features {
  }

  client_id       = var.microsoft_entra_id_app_client_id
  client_secret   = var.microsoft_entra_id_app_client_secret
  tenant_id       = var.microsoft_azure_tenant_id
  subscription_id = var.microsoft_azure_subscription_id
}


resource "azurerm_resource_group" "project_resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "project_storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.project_resource_group.name
  location                 = azurerm_resource_group.project_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_container_registry" "project_container_registry" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.project_resource_group.name
  location            = azurerm_resource_group.project_resource_group.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_virtual_network" "project_vm_vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.project_resource_group.location
  resource_group_name = azurerm_resource_group.project_resource_group.name
}

resource "azurerm_subnet" "project_vm_vnet_subnets_default" {
  name                 = var.virtual_network_subnet_name
  resource_group_name  = azurerm_resource_group.project_resource_group.name
  virtual_network_name = azurerm_virtual_network.project_vm_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "project_vm_public_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.project_resource_group.location
  resource_group_name = azurerm_resource_group.project_resource_group.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "project_vm_nic" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.project_resource_group.location
  resource_group_name = azurerm_resource_group.project_resource_group.name

  ip_configuration {
    name                          = var.network_interface_ip_conf_name
    subnet_id                     = azurerm_subnet.project_vm_vnet_subnets_default.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.project_vm_public_ip.id
  }
}

resource "azurerm_network_security_group" "project_nsg" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.project_resource_group.location
  resource_group_name = azurerm_resource_group.project_resource_group.name

  security_rule {
    name                       = "allow-https"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-ssh"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "project_nsg_association" {
  subnet_id                 = azurerm_subnet.project_vm_vnet_subnets_default.id
  network_security_group_id = azurerm_network_security_group.project_nsg.id
}

resource "azurerm_linux_virtual_machine" "project_virtual_machine" {
  name                            = var.virtual_machine_name
  resource_group_name             = azurerm_resource_group.project_resource_group.name
  location                        = azurerm_resource_group.project_resource_group.location
  size                            = "Standard_B2s"
  admin_username                  = var.virtual_machine_admin_username
  admin_password                  = var.virtual_machine_admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.project_vm_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y"
    ]

    connection {
      type     = "ssh"
      user     = var.virtual_machine_admin_username
      password = var.virtual_machine_admin_password
      host     = azurerm_public_ip.project_vm_public_ip.ip_address
    }
  }
}
