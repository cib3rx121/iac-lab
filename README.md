# IaC Lab

Personal homelab for **Infrastructure as Code**: **Proxmox VE** as the hypervisor, **Terraform** to provision Linux VMs from templates (**cloud-init**, static networking, SSH keys), with Ansible and Kubernetes planned next. The repository is safe to publish: **no secrets** in Git (tokens and `terraform.tfvars` stay local).

## Scope

Terraform drives the **Proxmox HTTP API** (`https://<host>:8006/api2/json`). The values in `terraform.tfvars` must match the **real network** where Proxmox and guest VMs live. The example file uses **`192.168.122.0/24`**, which is the usual range for libvirt’s **default NAT**; on a physical LAN you would use your own prefix and gateway.

Typical stack: **Linux host (KVM)** → **Proxmox VM** → **workload VM** created by Terraform (e.g. future Kubernetes node).

## What’s in the repo

| Path | Purpose |
|------|---------|
| `terraform/` | `proxmox_vm_qemu` (provider **telmate/proxmox**): clone from template, cloud-init (`ciuser`, `ipconfig0`, `ssh_public_key` in `terraform.tfvars`), disks and bridge. |

```
iac-lab/
├── README.md
├── .gitignore
└── terraform/
    ├── main.tf
    ├── provider.tf
    ├── variables.tf
    ├── terraform.tfvars.example
    └── .terraform.lock.hcl
```

Copy `terraform/terraform.tfvars.example` to **`terraform.tfvars`** and edit it locally. **`terraform.tfvars`** and **`*.tfstate`** are gitignored.

## Host: KVM (recommended)

Running Proxmox **inside KVM/libvirt** is generally more predictable than nesting the same workload under **VirtualBox**. Install `qemu-kvm`, `libvirt-daemon-system`, `libvirt-clients`, `virtinst`; add your user to **`libvirt`** and **`kvm`**, then re-login. Optional: **`virt-manager`**, **`qemu-utils`**.

Build the Proxmox VM on the host however you prefer (e.g. **virt-manager** with the Proxmox ISO, libvirt’s **default** NAT network, disk size, CPU/RAM). This repository only assumes a reachable Proxmox API and a suitable template; it does not create the Proxmox host VM for you.

Enable **nested virtualisation** on the host if you run VMs inside Proxmox. With only libvirt NAT, the host reaches Proxmox on **`192.168.122.x`**; inner guests on the same RFC1918 range may need **routing or forwarding** on Proxmox, or **SSH jump** via the node, depending on topology.

## Proxmox checklist (before `terraform apply`)

1. Repositories: disable paid **enterprise** repos without a subscription; enable **No-Subscription** where appropriate for a lab.
2. Automation **user** and **role** (principle of least privilege in production; broader role acceptable in a closed lab).
3. **API token** under *Datacenter → Permissions → API Tokens*; store the **secret** only in `terraform.tfvars`. Token ID format: `user@realm!tokenname`.
4. A **template** whose name matches **`vm_template`** (e.g. `ubuntu-2404-template`), suitable for **cloud-init** clones.

**Cloud-init drive:** With **telmate/proxmox 3.x**, a clone that only declares `scsi0` under `disks` may end up **without** the cloud-init volume, so `ipconfig0` / SSH keys never reach the OS (Proxmox UI: *“No CloudInit Drive found”*). This repo declares **`disks.ide.ide2.cloudinit`** plus **`boot = "order=scsi0;ide2"`** in `main.tf` so Terraform creates that volume explicitly. For VMs created before that change, add the drive in the UI once or recreate the resource.

## Terraform

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit: API URL, token id/secret, node, template, CIDR, gateway, vm_name, cloudinit_user, ssh_public_key
# (Optional overrides: vm_id, proxmox_storage, network_bridge — see variables.tf defaults.)

terraform init
terraform plan
terraform apply
```

Variables are in `variables.tf`. Set **`ssh_public_key`** in `terraform.tfvars` (one line, same key you use on your workstation); never commit the private key.

## Roadmap

More Terraform variables/modules, **Ansible** on nodes, **Kubernetes** bootstrap, sample workload — incremental commits.
