

data "azurerm_mysql_flexible_server" "sqlsrvid" {
  for_each = var.todo_database
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_mysql_flexible_database" "app_database" {
  for_each = var.todo_database
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  server_name         = data.azurerm_mysql_flexible_server.sqlsrvid[each.key].name
  charset             = each.value.charset
  collation           = each.value.collation
}