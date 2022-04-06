terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.6"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://10.0.0.253:8006/api2/json"
  pm_api_token_id = "terraform-op@pam!mytoken"
  pm_api_token_secret = "0570085f-9bc0-4e8a-819b-5a9331354cb2"
  pm_debug = true
  pm_tls_insecure = true
  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

#
#resource "proxmox_vm_qemu" "test_vm" {
#    name = "test-vm"
#    target_node     = "ml350p"
#    vmid            = 102
#    network {
#        bridge      = "vmbr120"
#        firewall    = false
#        link_down   = false
#        model       = "virtio"
#    }
#}

resource "proxmox_vm_qemu" "example" {
    name = "example-vm"
    target_node = "ml350p"
    vmid = 999
    clone = "test-vm"
}