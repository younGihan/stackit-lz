# STACKIT Project + SNA Landing Zone

Creates a STACKIT project and places it into one of three pre-existing STACKIT Network Areas
(SNAs) — `prod`, `qa`, `test` — based on the `environment` tag of the triggering meshProject, then
allocates that project its own network range within the chosen SNA.

## What it does

1. Looks up the meshProject (`workspace_identifier` + `project_name`) and reads its `environment`
   tag (configurable via `environment_tag_name`).
2. Maps that value to one of the three SNAs in `sna_network_area_ids`.
3. Reads the SNA's currently registered network ranges and computes the next free block from the
   environment's supernet (`network_base_cidrs`) — e.g. if `10.10.1.0/24`, `10.10.2.0/24` and
   `10.10.3.0/24` are already registered, it computes `10.10.4.0/24`.
4. Registers that range on the SNA (`stackit_network_area_region`) and creates the STACKIT project
   (`stackit_resourcemanager_project`) with the `networkArea` label set, plus a `stackit_network`
   inside the project using the new range.
5. If `network_range_override` is set instead, skips the computation and reuses the given CIDR
   (it's still added to the SNA if not already registered, otherwise it's a no-op).

## Inputs

Two inputs drive the run, as requested — everything else is landing-zone configuration set once
per environment (see `terraform.tfvars.example`):

- `workspace_identifier` — meshStack workspace of the triggering meshProject.
- `project_name` — meshProject name (and the resulting STACKIT project name).

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```

As a meshStack building block, `workspace_identifier` is wired to `WORKSPACE_IDENTIFIER` and
`project_name` is a `USER_INPUT`; the rest are `STATIC` platform-team inputs (see
`meshcloud/meshstack-hub`'s `modules/stackit/project/buildingblock` for the general pattern this
template follows). `backplane/` registers exactly this in meshStack - run it once, then order
instances (see `../starter-kit` for an example consumer).

## Known limitation

`stackit_network_area_region` manages an SNA's *entire* range list, so two project creations for
the same environment applying concurrently can race and overwrite each other's newly added range.
Serialize applies per environment (e.g. a separate Terraform state/lock per SNA, or a queued
building block runner) if concurrent project creation is expected.
