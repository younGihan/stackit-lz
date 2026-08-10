# STACKIT Project Creation - Backplane

Registers `../buildingblock` (the stackit-project-creation Terraform implementation) as a
meshStack building block definition ("STACKIT Project Creation", `TENANT_LEVEL`). Run once by the
platform team per environment/setup; app teams (or other building blocks) then order instances of
it against a STACKIT tenant.

`project_name` is auto-derived from the target tenant's owning project (`PROJECT_IDENTIFIER`), and
`workspace_identifier` from that tenant's owning workspace (`WORKSPACE_IDENTIFIER`). Everything
else - the SNA IDs, the environments' base CIDRs, and the STACKIT organization/owner/service-account
details - is baked into the registered version as `STATIC` inputs.

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```

Take note of the `building_block_definition_version_uuid` output - it's what any consumer (such as
`../../starter-kit/backplane`) needs to order instances of this building block.

## Updating

Because `bbd_draft` defaults to `true`, re-applying after changing platform config (e.g. adding a
new SNA) updates the existing draft version in place - no need to bump anything manually. Set
`bbd_draft = false` once the definition is stable to publish an immutable released version instead
(new changes then require a fresh `terraform apply`, which creates a new version).
