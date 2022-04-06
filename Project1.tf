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
  pm_api_token_id = "TerraformProv@pam!my_token"
  pm_api_token_secret = "782c9089-21d7-4cc9-92e4-f55639dd5bdd"
  pm_debug = true
  pm_tls_insecure = true
  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}


resource "proxmox_vm_qemu" "test_vm" {
    
    

    name        = "test-vm"
    target_node = "ml350p"
    pool        = "Services"
    onboot      = false
    qemu_os     = "l26"
    full_clone  = false

    // CPU
    sockets = 1
    cores   = 1
    memory  = 2048
    
    // CLOUD-INIT
    ipconfig0   = "ip=10.0.0.200/24,gw=10.0.0.254"
    ciuser      = "ansible-op"
    sshkeys     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpEHNtySuF99P5t8RTO1TfZ4l3FynFErTqJQC6lM2TV ansible-op@ansible-server"

    network {
        bridge      = "vmbr120"
        firewall    = false
        link_down   = false
        model       = "virtio"
    }

    disk {
    //    id              = 0
        type            = "scsi"
        storage         = "local-lvm"
        size            = "32972M"
        backup          = 0
    }
    
}

/*
resource "proxmox_vm_qemu" "example" {
    name = "example-vm"
    agent = 0
    boot  = "order=net0;scsi0"
    target_node = "ml350p"
    vmid = 999
    pxe = true
    network {
        bridge      = "vmbr120"
        firewall    = false
        link_down   = false
        model       = "virtio"
    }
}
*/
