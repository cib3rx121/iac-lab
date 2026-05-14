variable "proxmox_api_token_secret" {
  type        = string
  sensitive   = true
  description = "Proxmox API token secret (value shown only once when the token is created)."
}

variable "proxmox_api_token_id" {
  type        = string
  description = "Full API token identifier, e.g. automation-user@pve!token-name."
}

variable "proxmox_api_url" {
  type        = string
  description = "Proxmox API base URL, e.g. https://192.168.122.200:8006/api2/json"
}

variable "proxmox_node" {
  type        = string
  description = "Proxmox node name to run the VM on, e.g. pve."
}

variable "vm_template" {
  type        = string
  description = "Name of the template or VM to clone from, e.g. ubuntu-2404-template."
}

variable "master_ip_cidr" {
  type        = string
  description = "Static IPv4 for the cloned VM with CIDR mask, e.g. 192.168.122.201/24."
}

variable "master_gateway" {
  type        = string
  description = "IPv4 default gateway for the cloned VM, e.g. 192.168.122.1."
}

variable "vm_name" {
  type        = string
  description = "VM name in Proxmox, e.g. k8s-master-01."
}

variable "cloudinit_user" {
  type        = string
  description = "Linux user created by cloud-init on the cloned VM, e.g. dev."
}

variable "vm_id" {
  type        = number
  description = "Proxmox VMID for this machine (must be unique on the node), e.g. 100."
  default     = 100
}

variable "proxmox_storage" {
  type        = string
  description = "Storage pool for the root disk and cloud-init volume, e.g. local-lvm."
  default     = "local-lvm"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for the cloud-init user (single line, e.g. ssh-rsa AAAA... comment)."
}

variable "network_bridge" {
  type        = string
  description = "Proxmox bridge attached to net0, e.g. vmbr0."
  default     = "vmbr0"
}
