terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.63.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}