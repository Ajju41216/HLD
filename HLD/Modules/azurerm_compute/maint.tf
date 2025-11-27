
# we used data block to fetch the resouce details which is already thrir in Cloud.

data "azurerm_subnet" "subnet" {
  for_each             = var.new_vms
  name                 = each.value.subnetname
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

#local to have multiple NIC

locals {
  all_nics = merge([
    for vm_key, vm in var.new_vms : {
      for nic_key, nic in vm.nics :
      "${vm_key}-${nic_key}" => {
        vm_name    = vm_key       # vm1, vm2...
        nic_name   = nic.nic_name # frontend-nic1, etc.
        is_primary = nic.is_primary
      }
    }
  ]...)
}

# public IP
resource "azurerm_public_ip" "pub_ip_block" {
  for_each = {
    for k, nic in local.all_nics : k => nic
    if nic.is_primary
  }
  name                = "${each.value.nic_name}-pip"
  location            = var.new_vms[each.value.vm_name].location
  resource_group_name = var.new_vms[each.value.vm_name].resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "vms_nic" {
  for_each            = local.all_nics
  name                = each.value.nic_name
  location            = var.new_vms[each.value.vm_name].location
  resource_group_name = var.new_vms[each.value.vm_name].resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.subnet[each.value.vm_name].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = each.value.is_primary ? azurerm_public_ip.pub_ip_block[each.key].id : null
  }
}


resource "azurerm_linux_virtual_machine" "example" {
  for_each                        = var.new_vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = "testadminuser"
  admin_password                  = "Cidrtest@123"
  disable_password_authentication = each.value.disable_password_authentication

  network_interface_ids = [
    for nic_key, nic in azurerm_network_interface.vms_nic :
    nic.id if local.all_nics[nic_key].vm_name == each.key
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  for_each = azurerm_network_interface.vms_nic
  network_interface_id      = each.value.id
  network_security_group_id = var.nsg_id
}
