provider "azurerm" {
    features {}
  client_id       = "78181a14-030b-44bf-aa83-75e14e20fb3e"
  client_secret   = "no-8Q~ndFA-6cLFaLRb6J9kBOBljLvXXXub3VcLo"
  tenant_id       = "6b674dc1-d471-4f40-8aeb-58b6dd15fb07"
  subscription_id = "11447c33-b697-4a6c-b487-501a22f4309c"
  
}

module "RG" {
  source = "../InfraModules/RG_Module"
  resource_group_name = "my-resource-group"
  resource_group_location = "centralindia"
}   

module "Network" {
  source = "../InfraModules/Network_Module"
  virtual_network_name = "my-vnet"
  ip = ["10.0.0.0/16"]
  subnet_name = "my-subnet"
  sub-ip = ["10.0.1.0/24"]
  virtual_network_location = module.RG.Resource_Group_location
  resource_group_name = module.RG.Resource_Group_name
}

module "pip" {
  source = "../InfraModules/PIP_Module"
  pip_name = "my-public-ip"
  pip_location = module.RG.Resource_Group_location
  resource_group_name = module.RG.Resource_Group_name
}

module "nic" {
  source = "../InfraModules/nic_module"
  nic_name = "my-nic"
  nic_location = module.RG.Resource_Group_location
  resource_group_name = module.RG.Resource_Group_name
  subnet_id = module.Network.subnet_id
  pip_id = module.pip.pip_id
}

module "nsg" {
  source = "../InfraModules/NSG_Module"
  nsg_name = "my-nsg"
  nsg_location = module.RG.Resource_Group_location
  resource_group_name = module.RG.Resource_Group_name
}

module "vm" {
  source = "../InfraModules/VM_Module"
  vm_name = "my-vm"
  vm_location = module.RG.Resource_Group_location
  resource_group_name = module.RG.Resource_Group_name
  nic_id = module.nic.nic_id
}