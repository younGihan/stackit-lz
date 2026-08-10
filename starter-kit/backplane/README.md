# Starter Kit - Backplane

Registers `../buildingblock` (the starter-kit Terraform implementation) as a meshStack building block
definition ("STACKIT QA+Prod Bootstrap", `WORKSPACE_LEVEL`), so the qa+prod provisioning flow can
be ordered like any other building block instead of only being run as a raw `terraform apply`.

## Prerequisite

`../../stackit-project-creation/backplane` must already be applied - this backplane needs its
`building_block_definition_version_uuid` output as `stackit_project_creation_bb_version_uuid`.

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```

After applying, order an instance of the resulting "STACKIT QA+Prod Bootstrap" definition against
a target workspace (via the meshStack UI, or a `meshstack_building_block` resource) to actually
create that workspace's qa/prod meshProjects and STACKIT projects.
