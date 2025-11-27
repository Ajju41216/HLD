output "storage_account_ids" {
  value = { for k, sa in azurerm_storage_account.str_test : k => sa.id }
}
