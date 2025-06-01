variable "resource_group_name" {
  description = "The name of the resource group where the resources will be created."
  type        = string
  default     = "databricks-rg"
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "databricks-vnet"
}

variable "vnet_address_space" {
    description = "The address space for the virtual network."
    type        = string
    default     = "10.0.0.0/16"
}

variable "public_subnet_name" {
  description = "The name of the public subnet."
  type        = string
  default     = "public-subnet"
}

variable "public_subnet_prefix" {
    description = "The address prefix for the public subnet."
    type        = string
    default     = "10.0.1.0/24"
}

variable "private_subnet_name" {
  description = "The name of the private subnet."
  type        = string
  default     = "private-subnet"
}

variable "private_subnet_prefix" {
  description = "The address prefix for the private subnet."
  type        = string
  default     = "10.0.2.0/24"
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
  default     = "databricks-nsg"
}

variable "storage_account_name" {
  description = "Base name for the Azure Data Lake Storage account."
  type        = string
  default     = "databricksadls"
}

variable "container_name" {
  description = "Name of the Data Lake Storage container"
  type        = string
  default     = "unity-catalog"
}

variable "databricks_workspace_name" {
  description = "Name of the Azure Databricks Workspace"
  type        = string
  default     = "databricks-workspace"
}
