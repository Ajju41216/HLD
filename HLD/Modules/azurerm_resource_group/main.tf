locals {
  comman_tag = {
    App_id      = "Storage_account_with_dynamic"
    environment = "preprod"
    cost_center = "lavjeet-cost_center"
  }
  stg_specfic_tag = {
    company   = "Nokia"
    Deparment = "CNS Iptel"
  }

}

resource "azurerm_resource_group" "rg_block" {
    for_each = var.rgs
    name     = each.value.name
    location = each.value.location
    tags     = merge(local.comman_tag, local.stg_specfic_tag)
}
