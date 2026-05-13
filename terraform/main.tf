resource "proxmox_vm_qemu" "k8s_master" {
  name        = var.vm_name
  target_node = var.proxmox_node
  vmid        = 100

  clone = var.vm_template

  agent    = 1
  os_type  = "cloud-init"
  cores    = 2
  sockets  = 1
  vcpus    = 2
  cpu_type = "host"
  memory   = 2048
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disks {
    scsi {
      scsi0 {
        disk {
          size    = 20
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=${var.master_ip_cidr},gw=${var.master_gateway}"

  ciuser  = var.cloudinit_user
  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNCDUWUStNSuSGTmvETVvFuUfSpcq0UWfEdhVdiW9ow0NHGB12mmJ7OtMVQaSsTmx0/+iuakqmTYOSFGo1UH5QnCmjlCwEfirIbsaXlk82j48qAv+KAvP3GHnf69heFOSYTyJeCJZInPrG4acd+pbCKKSAQ2nX+5nXq1NBa4HOWu7llLozxmdqj1Bqbbac7/nqQTYr/9lEu/XQyHJSOojxFUx3JvJy6fhsGx6XYrvRHbX2EZw0PQQEWY06alxUTEDfJ9hxBtU67MrLIGSfoFj5dE6Qq0Phny7e6AJMQbyEE4degIRL+RsqZp3Swgvv31v6kGyDJZ/yuLvygMJr/cLn/OVGI9kGEGzbhvDk9RFv7kU3UJqWQKkJxVfn62kPM/XvLermA/BBI/7bn4NdmwX9dm98nZosQeTX+5iyFt91w5Io9MkT+PEhQg4YYhLotMfxwvB43xpYWD394EXK0uSzLy36Yg6AkPCb8uQc4F/JHL1s8M6GMav3hB8X7INmiTdGXsVnx3Zr8RebcuaLHRRSCtcREiDMHVH14wklcAIZrKjyq8UkSp3LvJ30xht6QvaTTtxG7qdq/NCOMstMSGuEXXJyrpb/VFbMgIlSaYoYyj+Yd+jlyZGpCmUNFd/u80tCbvlLxSzXuoVuiGUcVrovQJGdD02IjXX7PjSn7H2mRw== ciberx@UbuntuLab
EOF
}