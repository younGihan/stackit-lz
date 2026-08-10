# STACKIT Network Area Range

Adds a new network range to an *existing* STACKIT Network Area (SNA), computing the next free
block from a supernet.

## What it does

1. Reads the SNA's currently registered network ranges (`data.stackit_network_area_region`).
2. Computes the next free block from `network_base_cidr` - e.g. if `10.10.1.0/24`, `10.10.2.0/24`
   and `10.10.3.0/24` are already registered, it computes `10.10.4.0/24`.
3. Registers that range on the SNA (`stackit_network_area_region`), preserving every other setting
   (transfer network, prefix bounds, nameservers) unchanged.
4. If `network_range_override` is set instead, skips the computation and adds/reuses the given CIDR
   (a no-op if it's already registered).

## Prerequisite

The SNA's region must already be configured for the target `stackit_region` - see
`../../stackit-network-area-bootstrap`. Reading an unconfigured region's ranges fails hard with
`Region configuration for "<region>" does not exist.`

## Usage

```sh
terraform init
terraform apply -var-file=terraform.tfvars
```

As a meshStack building block (`WORKSPACE_LEVEL`), `network_area_id`, `network_base_cidr`,
`network_prefix_length` and `network_range_override` are `USER_INPUT`; the STACKIT
organization/service-account/region are `STATIC` platform-team inputs. `../backplane` registers
exactly this in meshStack.

## Known limitation

`stackit_network_area_region` manages an SNA's *entire* range list, so two orders against the same
SNA applying concurrently can race and overwrite each other's newly added range. Serialize applies
per SNA (e.g. a separate Terraform state/lock, or a queued building block runner) if concurrent
ordering is expected.
