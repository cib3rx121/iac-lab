variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_id" {
  type        = string
  description = "ID do API token (ex.: terraform-prov@pve!nome-do-token)"
}

variable "proxmox_api_url" {
  type        = string
  description = "URL da API Proxmox (ex.: https://192.168.56.200:8006/api2/json)"
}

variable "proxmox_node" {
  type        = string
  description = "Nome do nó Proxmox (ex.: pve)"
}

variable "vm_template" {
  type        = string
  description = "Nome do template para clone (ex.: ubuntu-2404-template)"
}

variable "master_ip_cidr" {
  type        = string
  description = "IPv4 da VM com máscara CIDR (ex.: 192.168.56.201/24)"
}

variable "master_gateway" {
  type        = string
  description = "Gateway IPv4 (ex.: 192.168.56.1)"
}

variable "vm_name" {
  type        = string
  description = "Nome da VM (ex.: k8s-master-01)"
}

variable "cloudinit_user" {
  type        = string
  description = "User criado na VM (ex.: dev)"
}