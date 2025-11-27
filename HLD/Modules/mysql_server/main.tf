
resource "azurerm_mysql_flexible_server" "sqlserver" {
    for_each = var.mysql_server
  name                   = each.value.name
  resource_group_name    = each.value.resource_group_name
  location               = each.value.location
  administrator_login    = each.value.administrator_login
  administrator_password = each.value.administrator_password
  sku_name               = each.value.sku_name
}


resource "azurerm_mysql_flexible_database" "app_database" {
  for_each = var.todo_database
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
 # server_name         = data.azurerm_mysql_flexible_server.sqlsrvid[each.key].name
   server_name = azurerm_mysql_flexible_server.sqlserver["mysql-1"].name
  charset             = each.value.charset
  collation           = each.value.collation
}