resource "azurerm_storage_account" "str_test" {
  for_each = var.rgs_sa
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}

resource "azurerm_storage_container" "str_test_container" {
  for_each = var.str_container
  name                  = each.value.name
  storage_account_id = azurerm_storage_account.str_test[each.value.storage_account_key].id 
  container_access_type = each.value.container_access_type
}