# Setting Up Azure resources

Required resources:

- Resource Group
- Storage Account
- Virtual Machine (VM)
- Container Registries

## Resource Group

All subsequent resources will be previosioned within this Resource Group. Please refer follow [these instructions](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal#create-resource-groups) to create an Azure Resource Group.

Make sure to pick the relevant [Azure Region](https://gist.github.com/ausfestivus/04e55c7d80229069bf3bc75870630ec8). In this project, `(Asia Pacific) Southeast Asia` is chosen as default location.

## Storage Account

To simplify, make the following configuration and keep the rest as default.

- Region: `(Asia Pacific) Southeast Asia`
- Redundancy: Locally redundant-storage (LRS)

## Virtual Machine (VM)

To simplify, make the following configuration and keep the rest as default.

**Basics**:
- Region: `(Asia Pacific) Southeast Asia`
- Availability options: No infrastructure redundancy required
- Security type: Standard
- Image: Ubuntu Server 22.04 LTS - x64 Gen2
- Size: Standard_B2s
- Authentucation type: Password
- Inbount ports: SSH and HTTPS

**Networking**:
- Delete NIC when VM is deleted: True

## Container Registry

To simplify, make the following configuration and keep the rest as default.

- Pricing plan: Basic