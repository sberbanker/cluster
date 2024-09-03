variable "virtual_environment_endpoint" {
  type        = string
  description = "The endpoint for the Proxmox Virtual Environment API (example: https://host:port)"
}

variable "virtual_environment_token" {
  type        = string
  description = "The token for the Proxmox Virtual Environment API"
}

variable "node_map" {
  type = map(string)
  default = {
    "node1" = "pve1",
    "node2" = "pve2",
    "node3" = "pve3"
  }
}

variable "vm_object" {
  type = map(object({
    target_node = string
    name        = string
    vm_id       = number
    ip          = string
    mac         = string
    sockets     = number
    dedicated   = number
    size        = number
  }))
  default = {
    "node1" = {
      target_node = "pve1"
      vm_id       = 40001
      name        = "docker-worker-1"
      ip          = "192.168.1.11/24"
      mac         = "BC:24:11:CD:EB:CA"
      sockets     = 4
      dedicated   = 24576
      size        = 500
    },
    "node2" = {
      target_node = "pve2"
      vm_id       = 40002
      name        = "docker-worker-2"
      ip          = "192.168.1.12/24"
      mac         = "BC:24:11:9D:35:5B"
      sockets     = 4
      dedicated   = 24576
      size        = 500
    },
    "node3" = {
      target_node = "pve3"
      vm_id       = 40003
      name        = "docker-worker-3"
      ip          = "192.168.1.13/24"
      mac         = "BC:24:11:CB:A2:1B"
      sockets     = 4
      dedicated   = 24576
      size        = 500
    },
    "node4" = {
      target_node = "pve3"
      vm_id       = 40004
      name        = "docker-manager-1"
      ip          = "192.168.1.14/24"
      mac         = "BC:24:11:CD:BD:40"
      sockets     = 1
      dedicated   = 4096
      size        = 40
    }
  }
}