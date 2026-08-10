# STACKIT Network

Creates a `stackit_network` inside an existing STACKIT project.

No manual CIDR math: `ipv4_prefix` is left unset, so STACKIT auto-allocates a free block of
`network_prefix_length` from the project's SNA pool. The project's SNA must already have a region
configured (see `../../stackit-project-creation/network-area-bootstrap`) or this will fail.

## What it does

Creates a single `stackit_network` in `project_id`, named `network_name`.

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```

As a meshStack building block (`TENANT_LEVEL`), `project_id` is wired to `PLATFORM_TENANT_ID`
(auto-derived from the target STACKIT tenant); `network_name`, `network_prefix_length`, `routed`
and `ipv4_nameservers` are `USER_INPUT`. `../backplane` registers exactly this in meshStack.
