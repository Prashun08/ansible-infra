resource "azurerm_public_ip" "workers" {
  for_each            = local.worker_vms
  name                = "pip-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags
}

resource "azurerm_network_interface" "workers" {
  for_each            = local.worker_vms
  name                = "nic-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.workers.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.workers[each.key].id
  }
  tags = local.common_tags
}

resource "azurerm_linux_virtual_machine" "workers" {
  for_each            = local.worker_vms
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = each.value.size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.workers[each.key].id
  ]
  disable_password_authentication = true
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  tags = local.common_tags
}

