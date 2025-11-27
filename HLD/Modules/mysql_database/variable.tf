variable "todo_database" {
  type = map(object({
    name                = string
    resource_group_name = string
    charset             = string
    collation           = string
    }))
}