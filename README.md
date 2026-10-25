# Azure/IaC project

This project utilizes Terraform and GitHub Actions to build and deploy to Azure a fleet-health data service. The application itself monitors device health based on singals like compliance status and update rings.

## Scope

**In scope**
- Synthetic device data
- Use of a personal pay-as-you-go Azure subscription
    - Azure services that will be used include Azure Blob Storage, Entra ID, Virtual Network + NSG, Key Vault, RBAC, Container Registry, Container Apps, SQL Database, and Azure Monitor
- Terraform
- GitHub Actions

**Out of scope**
- Azure services not listed above
- Production device data
- Kubernetes

