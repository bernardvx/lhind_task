output "resource_group_id" {
  description = "ID of the created Resource Group"
  value       = azurerm_resource_group.rg.id
}

output "vnet_id" {
  description = "ID of the created Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = azurerm_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = azurerm_subnet.private.id
}

output "storage_account_name" {
  description = "The name of the Azure Data Lake Storage account"
  value       = azurerm_storage_account.adls.name
}

output "databricks_workspace_url" {
  description = "URL of the Azure Databricks Workspace"
  value       = azurerm_databricks_workspace.databricks.workspace_url
}