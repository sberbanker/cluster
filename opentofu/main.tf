terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
 pm_api_url   = "https://192.168.0.100:8006/api2/json"
 pm_user      = "terraform-prov@pve"
 pm_password  = "your-api-key"
 pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "my_vm" {
 name       = "my-vm"
 target_node = "pve1"
 clone      = "ubuntu-template"
 storage    = "local-lvm"
 cores      = 2
 memory     = 2048
}
