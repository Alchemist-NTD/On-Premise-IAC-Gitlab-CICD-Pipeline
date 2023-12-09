variable "pm_api_url" {
  type = string
}

variable "pm_api_token_id" {
  type = string
  sensitive = true
}

variable "pm_api_token_secret" {
  type = string
}

variable "template_name" {
  default = "ubuntu-2004-cloudinit-template"
}

terraform {
  required_providers {
    proxmox = {
        source = "telmate/proxmox"
        version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.pm_api_url
  pm_api_token_id = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure = true
  pm_debug = true
  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}
