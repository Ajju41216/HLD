
# to create Resource group
rgs = {
  rg1 = {
    name     = "rg-pilu-dev-todoapp-01"
    location = "centralindia"
  }
}

# first network along with Subnets
networks = {
  vnet1 = {
    name                = "vnet_1"
    location            = "centralindia"
    resource_group_name = "rg-pilu-dev-todoapp-01"
    address_space       = ["10.0.0.0/16"]
    subnets = [
      {
        name             = "subnet-01"
        address_prefixes = ["10.0.1.0/24"]
      },
      {
        name             = "subnet-02"
        address_prefixes = ["10.0.2.0/24"]
      }
    ]
  }
}

# nsg
nsg = {
    name                = "to-do-frt-nsg"
    location            = "centralindia"
    resource_group_name = "rg-pilu-dev-todoapp-01"
    security_rules = [
      {
        name                       = "nsg-rule1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  
}
# NIC following VM and key_vault
new_vms = {
  vm1 = {
    vm_name                         = "frountend-vm1"
    virtual_network_name            = "vnet_1"
    location                        = "centralindia"
    resource_group_name             = "rg-pilu-dev-todoapp-01"
    size                            = "Standard_B2s"
    disable_password_authentication = "false"
    # NICs as inner map
    nics = {
      nic1 = {
        nic_name   = "frontend-nic1"
        is_primary = "true"
      }
      nic2 = {
        nic_name   = "frontend-nic2"
        is_primary = "false"
      }
    }
    # these are the arguments that we need for data block of subnet and pip
    pip_name   = "pip-pilu-dev-todoapp-01"
    subnetname = "subnet-01"
    sku_name   = "standard"
  },
  vm2 = {
    vm_name                         = "frountend-vm2"
    virtual_network_name            = "vnet_1"
    location                        = "centralindia"
    resource_group_name             = "rg-pilu-dev-todoapp-01"
    size                            = "Standard_B2s"
    disable_password_authentication = "false"
    # NICs as inner map
    nics = {
      nic1 = {
        nic_name   = "frontend-nic3"
        is_primary = "true"
      }
      nic2 = {
        nic_name   = "frontend-nic4"
        is_primary = "false"
      }
    }
    # these are the arguments that we need for data block of subnet and pip
    pip_name   = "pip-pilu-dev-todoapp-02"
    subnetname = "subnet-02"
    sku_name   = "standard"
    # ngs group arguments
    nsg_name = "to-do-bck-nsg"
    nsg2 = [{
      name                       = "nsg-rule1"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      }
    ]
  }
}

