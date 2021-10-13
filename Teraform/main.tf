terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = "2.8.0"
        }
    }
}

provider "proxmox" {

    # full host name + /api2/json
    pm_api_url = "https://192.168.1.252:8006/api2/json"

    # API token id for user: teraform-test
    pm_api_token_id ="teraform-test@pve!new_token_id"

    # is just local so i don't care much atm but this isn't safe
    pm_api_token_secret =  "a70d8aaa-d615-4eaa-acfb-88e59be062b4"

    # NO SSL
    pm_tls_insecure = true
} 

resource "proxmox_lxc" "basic-test" {
  target_node  = "192.168.1.252:8006"
  hostname     = "basic-test1"
  ostemplate   = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  password     = "BasicLXCContainer"
  unprivileged = true

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-zfs"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}