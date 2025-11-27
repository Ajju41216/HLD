
variable "rgs_sa" {
    type = map(object({
    name     = string
    location = string
    resource_group_name = string
    account_replication_type = string
    account_tier = string
}))
}

variable "str_container" {
    type = map(object({
      name = string
      storage_account_key = string
      container_access_type = optional(string)
    }))  
}

