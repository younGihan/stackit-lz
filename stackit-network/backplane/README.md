# STACKIT Network - Backplane

Registers `../buildingblock` (the stackit-network Terraform implementation) as a meshStack
building block definition ("STACKIT Network", `TENANT_LEVEL`). Run once by the platform team; app
teams then order instances against their own STACKIT project's tenant.

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```
