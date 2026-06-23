resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.nsg_location
  resource_group_name = var.resource_group_name  #azurerm_resource_group.RG.name

   security_rule {
        name                       = "Allow-SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
    name                       = "allow-http"
    priority                   = 101               # Lower numbers have higher priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"              # Opens Port 80
    source_address_prefix      = "*"               # Allows traffic from anywhere
    destination_address_prefix = "*"
  }
}


