# STACKIT Network Area

Creates a new STACKIT Network Area (SNA) - `stackit_network_area` only.

This module deliberately does **not** configure the SNA's region (network ranges, transfer
network, prefix bounds). A freshly created SNA has no region set up, so no STACKIT project can be
placed on it yet (`stackit-project-sna` / `stackit-project-creation` will fail with `Region
configuration for "<region>" does not exist.` if you try). Run
`../../stackit-project-creation/network-area-bootstrap` once against the resulting `network_area_id`
before ordering any project onto this SNA.

## What it does

Creates a single `stackit_network_area` under `organization_id`, named `network_area_name`.

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```

As a meshStack building block (`WORKSPACE_LEVEL`), `network_area_name` is the only per-order input
(`USER_INPUT`); `organization_id` and the service account are `STATIC` platform-team inputs.
`../backplane` registers exactly this in meshStack.
