# Azure Data Engineering and Infrastructure task

## Azure Data Engineering Infrastructure Setup

### Overview

This Terraform project provisions the core Azure infrastructure required for a data engineering
pipeline using Azure-native services which are mentioned below.


### Provisioned Resources

The Terraform configuration creates the following Azure resources:

* Resource Group(databricks-rg)
* Virtual Network(databricks-vnet)
* Public Subnet(public-subnet)
* Private Subnet(private-subnet)
* Network Security Group(databricks-nsg)
* Azure Data Lake Storage Gen2(databricksadls)
* Azure Databricks Workspace(databricks-workspace)

Additional resources (e.g., Databricks Compute Cluster, SQL Warehouse, Unity Catalog setup, Access 
Connector, Storage Credentials, and External Location) are to be configured manually.


### Prerequisites

Before deploying the infrastructure, ensure you have:

* Terraform: Installation guide[https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli].
* Azure CLI: Installation guide[https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest#install].
* Azure Subscription: An active subscription with permissions to create resources.


### Deployment Instructions

**Navigate to the Infrastructure Directory**
```bash
cd infrastructure
```

**Initialize Terraform**

Run the following command to initialize the project and download the Azure provider:
```bash
terraform init
```

**Preview the Deployment**

Generate an execution plan to see what resources Terraform will create:
```bash
terraform plan
```

Review the output to ensure the resources match your expectations.


**Deploy the Infrastructure**

Apply the configuration to create the resources in Azure:
```bash
terraform apply
```

When prompted, type yes to confirm the creation of resources.

Verify Outputs:

After deployment, Terraform will display outputs (e.g., Resource Group ID, Databricks Workspace URL, Storage Account Name). These can be used for manual configuration in the Azure Portal.

> Example output:
```
resource_group_id = "/subscriptions/<sub-id>/resourceGroups/databricks-rg"
databricks_workspace_url = "https://adb-<id>.azuredatabricks.net"
storage_account_name = "databricksadls<random>"
```
**Access Resources**

Log in to the Azure Portal to verify the resources in the databricks-rg Resource Group.
Use the Databricks Workspace URL (from outputs) to access the workspace.


**Clean Up (Optional)**

To avoid ongoing Azure charges, destroy the resources when no longer needed:
```code
terraform destroy
```

Confirm by typing yes when prompted.
