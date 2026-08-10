# STACKIT Project on SNA - Backplane

Registers `../buildingblock` (the stackit-project-sna Terraform implementation) as a meshStack
building block definition ("STACKIT Project on SNA", `TENANT_LEVEL`). Run once by the platform team
per environment/setup; app teams (or other building blocks) then order instances of it against a
STACKIT tenant.

`project_name` is auto-derived from the target tenant's owning project (`PROJECT_IDENTIFIER`), and
`workspace_identifier` from that tenant's owning workspace (`WORKSPACE_IDENTIFIER`). Everything else
- the SNA IDs and the STACKIT organization/owner/service-account details - is baked into the
registered version as `STATIC` inputs.

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```

Take note of the `building_block_definition_version_uuid` output - it's what any consumer needs to
order instances of this building block.
