# STACKIT Network Area Range - Backplane

Registers `../buildingblock` (the stackit-network-area-range Terraform implementation) as a
meshStack building block definition ("STACKIT Network Area Range", `WORKSPACE_LEVEL`). Run once by
the platform team; whoever needs to grow an SNA's address pool then orders an instance.

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```
