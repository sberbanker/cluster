provider "proxmox" {
  endpoint  = var.virtual_environment_endpoint
  api_token = var.virtual_environment_token
  insecure = true
  ssh {
    agent    = true
    username = "root"
  }
}