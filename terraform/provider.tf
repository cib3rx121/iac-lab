terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }
}

# Proxmox (telmate): versão ≥ 3.0.2 alinha com PVE 8.x — o check mínimo de
# permissões ainda pedia VM.Monitor, que o pveum não lista nesta versão.
# Em lab desactivamos esse check; em produção rever a combinação PVE/provider.
provider "proxmox" {
  pm_api_url                  = var.proxmox_api_url
  pm_api_token_id             = var.proxmox_api_token_id
  pm_api_token_secret         = var.proxmox_api_token_secret
  pm_tls_insecure             = true
  pm_minimum_permission_check = false

}