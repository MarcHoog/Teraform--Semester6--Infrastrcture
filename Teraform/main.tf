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
    pm_api_token_secret =  var.token_secret

    # NO SSL
    pm_tls_insecure = true
} 

resource "proxmox_lxc" "basic-test" {
  count = length(var.computer_name)

  target_node  = "ve-hp"
  hostname     = var.computer_name[count.index]
  ostemplate   = "local:vztmpl/ubuntu-21.04-standard_21.04-1_amd64.tar.gz"
  password     = "BasicLXCContainer0"
  ostype       = "ubuntu"
  unprivileged = true

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "8G"
  }

  network {
    name    = "eth0"
    bridge  = var.networking_bridge
    mtu     = var.networking_mtu
    ip      = var.networking_ip
  }
}