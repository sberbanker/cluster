data "local_file" "ssh_public_key" {
  filename = "/home/alfes/.ssh/id_rsa.pub"
}

resource "proxmox_virtual_environment_vm" "fedora_vm" {

  depends_on = [
    proxmox_virtual_environment_download_file.fedora_cloud_image
  ]

  for_each = var.vm_object

  vm_id           = each.value.vm_id
  name            = each.value.name
  node_name       = each.value.target_node
  machine         = "q35"
  started         = true
  on_boot         = true
  bios            = "seabios"
  keyboard_layout = "en-us"
  migrate         = true


  agent {
    enabled = true
    trim    = true
    type    = "virtio"
  }

  initialization {
    datastore_id = "local-zfs"
    interface    = "scsi4"

    dns {
      servers = ["1.1.1.1", "8.8.8.8"]
    }

    ip_config {
      ipv4 {
        address = each.value.ip
        gateway = "192.168.1.1"
      }
    }

    user_account {
      username = "localadmin"
      # password = "password"
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }

  cpu {
    architecture = "x86_64"
    sockets      = each.value.sockets
    cores        = 2
  }

  memory {
    dedicated = each.value.dedicated
    floating  = 2048
  }

  network_device {
    bridge      = "vmbr0"
    enabled     = true
    firewall    = false
    model       = "virtio"
    mtu         = 1500
    queues      = 0
    rate_limit  = 0
    vlan_id     = 2
    mac_address = each.value.mac
  }

  disk {
    datastore_id = "local-zfs"
    file_id      = "local:iso/fedora40-1.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = each.value.size
    ssd          = true

  }
}

resource "proxmox_virtual_environment_download_file" "fedora_cloud_image" {

  for_each = var.node_map

  content_type = "iso"
  datastore_id = "local"
  node_name    = each.value
  url          = "http://download.fedoraproject.org/pub/fedora/linux/releases/40/Cloud/x86_64/images/Fedora-Cloud-Base-Generic.x86_64-40-1.14.qcow2"
  file_name    = "fedora40-1.img"
  overwrite    = false
}
