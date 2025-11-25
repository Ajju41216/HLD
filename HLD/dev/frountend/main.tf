module "rg" {
  source = "../../Modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "network" {
  source     = "../../Modules/azurerm_networking"
  depends_on = [module.rg]
  networks   = var.networks
}

module "nsg" {
  source     = "../../Modules/azurerm_nsg"
  depends_on = [module.rg]
  nsg        = var.nsg

}
module "compute" {
  depends_on = [module.network, module.rg]
  source     = "../../Modules/azurerm_compute"
  new_vms    = var.new_vms
  nsg_id = module.nsg.nsg_id
}