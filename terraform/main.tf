data "azurerm_virtual_network" "existing" {
  name                = "Test_Prod"
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "workers" {
  name                 = "workers-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "workers" {
  name                = "workers-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "workers" {
  subnet_id                 = azurerm_subnet.workers.id
  network_security_group_id = azurerm_network_security_group.workers.id
}

resource "azurerm_network_security_rule" "ssh" {
  name      = "AllowSSH"
  priority  = 100
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range      = "*"
  destination_port_range = "22"

  source_address_prefix      = "*"
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.workers.name
}

resource "local_file" "inventory" {
  filename = "${path.module}/../ansible/inventory.ini"

  content = templatefile(
    "${path.module}/templates/inventory.tpl",
    {
      workers = {
        for name, pip in azurerm_public_ip.workers :
        name => pip.ip_address
      }
    }
  )
}