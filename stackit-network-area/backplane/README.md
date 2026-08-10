# STACKIT Network Area - Backplane

Registers `../buildingblock` (the stackit-network-area Terraform implementation) as a meshStack
building block definition ("STACKIT Network Area", `WORKSPACE_LEVEL`). Run once by the platform
team; whoever needs a new SNA then orders an instance, providing just its name.

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```

## Next step after ordering an instance

A freshly created SNA has no region configured, so no project can be placed on it yet. Run
`../../stackit-project-creation/network-area-bootstrap` once against the new `network_area_id`
before using `stackit-project-sna` / `stackit-project-creation` against it.
