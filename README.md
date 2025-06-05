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

All of the initialising, planing and then applying by terraform will be automated 
via a an Azure Devops CI/CD pipeline. 

The setup is explained below.


## Azure DevOps Pipeline Setup for Terraform Deployment


### Prerequisites for Azure DevOps Pipeline

To successfully run a CI/CD pipeline in Azure DevOps for Terraform deployments, ensure the following requirements are met:

* **Azure DevOps Organization and Project**: 
You need an active Azure DevOps organization and a project to host the pipeline.

How to create an organization-> [https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/create-organization?view=azure-devops]
How to create a project-> [https://learn.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops&tabs=browser]

* **Azure Subscription**: 
An active Azure subscription with permissions to create and manage resources. 

How to create a subscription-> [https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/create-subscription]

* **Service Principal** 
A service principal in Azure Active Directory (AAD) with the following details:
    - Subscription ID: The ID of your Azure subscription.
    - Tenant ID: The AAD tenant ID (GUID or domain name, e.g., yourdomain.onmicrosoft.com).
    - Client ID: The application ID of the service principal.
    - Client Secret: A secret key for the service principal.

How to create a service principal->[https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal] 

* **Repository**: 
A Git repository (e.g., in Azure Repos or GitHub) containing your Terraform configuration files in an infrastructure directory.

How to link a Git repository to Azure Devops->[https://learn.microsoft.com/en-us/azure/devops/repos/git/import-git-repository?view=azure-devops]

### Pipeline-Specific Setup for This Terraform Deployment

**Pipeline Variables**

* Define the following variables in your Azure DevOps pipeline (under Pipelines > Edit > Variables):
    - SUBSCRIPTION_ID: Your Azure subscription ID (e.g., 12345678-1234-1234-1234-1234567890ab).
    - TENANT_ID: Your AAD tenant ID (e.g., 87654321-4321-4321-4321-0987654321ba or yourdomain.onmicrosoft.com).
    - CLIENT_ID: The service principal’s client ID (e.g., abcdefab-cdef-abcd-efab-cdefabcdefab).
    - CLIENT_SECRET: The service principal’s client secret (mark as a secret variable by clicking the lock icon).

These variables are mapped to environment variables (ARM_SUBSCRIPTION_ID, ARM_TENANT_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET) used by Terraform for authentication.

How to add variables to your pipeline->[https://learn.microsoft.com/en-us/azure/devops/pipelines/process/variables?view=azure-devops&tabs=yaml%2Cbatch]

**Parallel jobs**

Configure and pay for parallel jobs.

How to add parallel jobs->[https://learn.microsoft.com/en-us/azure/devops/pipelines/licensing/concurrent-jobs?view=azure-devops&tabs=ms-hosted]

### Pipeline Execution

The pipeline consists of three jobs within a single stage (BuildAndDeploy):

* Verify: Runs terraform fmt -check -recursive to ensure formatting and terraform init/terraform validate to validate the configuration.
* Plan: Runs terraform init and terraform plan to generate a plan, which is published as an artifact.
* Deploy: Downloads the plan artifact, runs terraform init, and applies the plan with terraform apply -auto-approve.

**Running the Pipeline**

* Push changes to the main branch to trigger the pipeline.
* See Trigger pipelines.
* Monitor the pipeline in Azure DevOps to ensure each job completes successfully.

**Finally**: 
* Check the created resources in the Azure portal under the specified resource group (e.g., databricks-rg). Access the portal at portal.azure.com.
