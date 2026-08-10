# Starter Kit

Demo/bootstrap template: creates two meshProjects (`qa` tagged `environment = qa`, `prod` tagged
`environment = prod`) in a workspace, then orders a STACKIT Project Creation instance against each.

This directory can be applied directly, or run itself as a meshStack building block via
`../backplane/` (see below).

## What it does

1. Creates two `meshstack_project` resources: `qa` and `prod`, each tagged with its `environment`.
2. Orders one `meshstack_building_block` instance per project against the already-registered
   **STACKIT Project Creation** building block version (`stackit_project_creation_bb_version_uuid`),
   each setting `project_name` to that project's name — this is what actually triggers
   `../../stackit-project-creation/buildingblock` to run and create the STACKIT project + network range.

## Prerequisites

- `../../stackit-project-creation/backplane` must already be applied - grab its
  `building_block_definition_version_uuid` output for `stackit_project_creation_bb_version_uuid`.
- The three SNAs (prod/qa/test) already exist in STACKIT — see
  `../../stackit-project-creation/buildingblock/README.md`.

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```

Building block runs are synchronous here (`async = false` on the STACKIT Project Creation
definition); check `qa_building_block_status` / `prod_building_block_status` after apply, or the
meshStack UI, to see the created STACKIT projects.

## Running this as an orderable building block instead

`../backplane/` registers this directory itself as a building block ("STACKIT QA+Prod Bootstrap"),
so an app team can order the whole qa+prod bootstrap flow instead of you needing to
`terraform apply` this directory by hand each time. See `../backplane/README.md`.
