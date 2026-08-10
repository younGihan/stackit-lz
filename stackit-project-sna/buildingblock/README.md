# STACKIT Project on SNA

Creates a STACKIT project and places it into one of two pre-existing STACKIT Network Areas
(SNAs) - `prod`, `dev` - based on the `environment` tag of the triggering meshProject.

Unlike `../../stackit-project-creation`, this module does not manage the SNA's network ranges at
all - it only sets the project's `networkArea` label. Use `../../stackit-network-area` to create a
new SNA, and configure its region (ranges/transfer network) separately before placing projects on
it - STACKIT rejects project creation on an SNA with no region configured for the target project's
region.

## What it does

1. Looks up the meshProject (`workspace_identifier` + `project_name`) and reads its `environment`
   tag (configurable via `environment_tag_name`).
2. Maps that value to one of the two SNAs in `sna_network_area_ids`.
3. Creates the STACKIT project (`stackit_resourcemanager_project`) named
   `<workspace_identifier>.<project_name>.<environment>`, with the `networkArea` label set to the
   selected SNA's ID.

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```

As a meshStack building block (`TENANT_LEVEL`), `workspace_identifier` is wired to
`WORKSPACE_IDENTIFIER` and `project_name` to `PROJECT_IDENTIFIER` (both auto-derived from the
target tenant); the rest are `STATIC` platform-team inputs. `../backplane` registers exactly this
in meshStack - run it once, then order instances against a STACKIT tenant.
