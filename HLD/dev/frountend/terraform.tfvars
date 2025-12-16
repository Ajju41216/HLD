# to create Resource group

rgs = {
  rg1 = {
    name     = "rg-pilu-dev-todoapp-01"
    location = "centralindia"
  }
}

# first network along with Subnets we used Dynanic Block
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

# nsg where we used rules with Dynamic Block
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
    # NICs as inner map we used Dynamic Block
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
    #arguments that we need for key_block
    name_key                   = "hldkey12vault32"
    soft_delete_retention_days = "7"

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
    #arguments that we need for key_block
    name_key                   = "hldkey234091vault"
    soft_delete_retention_days = "7"
  }
}

mysql_server = {
  mysql-1 = {
    name                   = "todo-database"
    location               = "centralindia"
    resource_group_name    = "rg-pilu-dev-todoapp-01"
    administrator_login    = "testadminuser"
    administrator_password = "Cidrtest@123"
    sku_name               = "B_Standard_B1ms"
  }
}

todo_database = {
  app-db = {
    name                = "my-application-db"
    resource_group_name = "rg-pilu-dev-todoapp-01"
    charset             = "utf8mb4"
    collation           = "utf8mb4_unicode_ci"

  }
}
