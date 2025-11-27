variable "mysql_server" {
  type = map(object({
    name                   = string
    resource_group_name    = string
    location               = string
    administrator_login    = string
    administrator_password = string
    sku_name               = string 
  }))
}

variable "todo_database" {
  type = map(object({
    name                = string
    resource_group_name = string
    charset             = string
    collation           = string
    }))
}