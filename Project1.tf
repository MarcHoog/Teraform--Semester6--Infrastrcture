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
  pm_api_token_id = "terraform-op@pam!mytoken"
  pm_api_token_secret = "0570085f-9bc0-4e8a-819b-5a9331354cb2"
}


resource "proxmox_vm_qemu" "test_vm" {
    name = "test-vm"
    target_node     = "ml350p"
    vmid            = 102
    network {
        bridge      = "vmbr120"
        firewall    = false
        link_down   = false
        model       = "virtio"
    }
}