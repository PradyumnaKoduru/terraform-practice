resource "azurerm_linux_virtual_machine" "MYVM" {
  name                = var.vm_name
  location            = var.vm_location
  resource_group_name = var.resource_group_name
  size                = "Standard_D2s_v3" # Replaced vm_size

  # Mapped from network_interface_ids
  network_interface_ids = [var.nic_id]

  # Mapped from os_profile
  computer_name                   = "hostname"
  admin_username                  = "testadmin"
  admin_password                  = "Password1234!"
  disable_password_authentication = false # Mapped from os_profile_linux_config

  # Modernized storage_os_disk block (Auto-deletes natively)
  os_disk {
    name                 = "myosdisk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS" # Replaced managed_disk_type
  }

  # Mapped from storage_image_reference
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "production"
  }

  # Connection block for your provisioners
  connection {
    type     = "ssh" # Explicitly declared for modern remote-exec
    user     = "testadmin"
    password = "Password1234!"
    host     = var.public_ip_address
  }

  provisioner "file" {
    source      = "${path.module}/nginx.sh"
    destination = "/tmp/nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx.sh",
      "/tmp/nginx.sh"
    ]
  }
}
