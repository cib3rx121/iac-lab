resource "proxmox_vm_qemu" "k8s_master" {
  name        = var.vm_name
  target_node = var.proxmox_node
  vmid        = var.vm_id

  clone = var.vm_template

  agent   = 1
  os_type = "cloud-init"

  cpu {
    cores   = 2
    sockets = 1
    type    = "host"
  }

  memory   = 2048
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  # PVE 8 / provider 3.x: clone + disks{} must include the cloud-init volume (ide2),
  # or ipconfig0 / sshkeys never reach the guest.
  boot = "order=scsi0;ide2"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.proxmox_storage
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = 20
          storage = var.proxmox_storage
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = var.network_bridge
  }

  ipconfig0 = "ip=${var.master_ip_cidr},gw=${var.master_gateway}"

  ciuser  = var.cloudinit_user
  sshkeys = var.ssh_public_key
}
