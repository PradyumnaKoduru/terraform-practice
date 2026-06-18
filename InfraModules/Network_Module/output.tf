output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_location" {
  value = azurerm_virtual_network.vnet.location
}

output "vnet_ip" {
  value = azurerm_virtual_network.vnet.address_space
}

output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "subnet_ip" {
  value = azurerm_subnet.subnet.address_prefixes
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

