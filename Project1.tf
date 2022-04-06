terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.6"
    }
  }
}

provider "proxmox" {
  pm_api_url = "10.0.0.253:8006/api2/json"
}


resource "proxmox_vm_qemu" "example" {
    name = "goink"
    target_node = "ml350p"
    vmid = 105
}