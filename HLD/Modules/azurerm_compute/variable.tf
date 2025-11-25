#variable "vms_nic" { 
# type = map(object({
#   name    = string
#     location = string
#     resource_group_name = string
#    # pip_name            = Optional(string)
#     subnetname          = string
#     virtual_network_name = string
#     ip_configurations = list(object({
#         name    = string
#     }))
# }))
#}


variable "new_vms" {
  type = map(object({
    vm_name                         = string
    virtual_network_name            = string
    location                        = string
    resource_group_name             = string
    size                            = string
    disable_password_authentication = bool
    pip_name                        = string
    subnetname                      = string
    #sku                             = string
    nics = map(object({
      nic_name   = string
      is_primary = bool # only one NIC per VM will get public IP
    }))
  }))
}

variable "nsg_id" {
  description = "The NSG ID to attach to NICs"
  type        = string
}