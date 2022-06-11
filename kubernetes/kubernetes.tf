terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.10"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://10.0.0.253:8006/api2/json"
  pm_api_token_id = "TerraformProv@pam!my_token"
  pm_api_token_secret = "782c9089-21d7-4cc9-92e4-f55639dd5bdd" # THIS is in a local closed of test environment
  pm_debug = true
  pm_tls_insecure = true
  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

resource "proxmox_vm_qemu" "kube-master00" {
    name = "kube-master00"
    agent = 1

    sockets = 1
    cores   = 8
    memory  = 16384

    target_node = "ml350p"
    onboot      = false
    qemu_os     = "l26"
    full_clone  = false
    clone       = "SRV-Ubuntu-Focal"

    // Cloud-init
    ipconfig0   = "ip=10.8.0.1/24,gw=10.8.0.254"
    ciuser      = "ansible-op"
    sshkeys     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpEHNtySuF99P5t8RTO1TfZ4l3FynFErTqJQC6lM2TV ansible-op@ansible-server"
    nameserver  = "10.0.0.1"
    searchdomain = "lab.mylocal"

    network {
    // IP config 0
      bridge    = "vmbr150"
      firewall  = false
      link_down = false
      model     = "virtio"
      macaddr   = "D6:53:9B:8E:20:A0"
  
    }

    disk {
    // ID 0
        type            = "scsi"
        storage         = "local-lvm"
        size            = "50380M"
        backup          = 0
    }
}

resource "proxmox_vm_qemu" "kube-worker01" {
    name = "kube-worker01"
    agent = 1

    sockets = 2
    cores   = 4
    memory  = 16384

    target_node = "ml350p"
    onboot      = false
    qemu_os     = "l26"
    full_clone  = false
    clone       = "SRV-Ubuntu-Focal"

    // Cloud-init
    ipconfig0   = "ip=10.8.0.2/24,gw=10.8.0.254"
    ciuser      = "ansible-op"
    sshkeys     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpEHNtySuF99P5t8RTO1TfZ4l3FynFErTqJQC6lM2TV ansible-op@ansible-server"
    nameserver  = "10.0.0.1"
    searchdomain = "lab.mylocal"
    
    
    network {
    // IP config 0
      bridge    = "vmbr150"
      firewall  = false
      link_down = false
      model     = "virtio"
      macaddr   = "E2:B4:D8:FB:C0:38"
    
    }

    disk {
    // ID 0
        type            = "scsi"
        storage         = "local-lvm"
        size            = "29900M"
        backup          = 0
    }
}

resource "proxmox_vm_qemu" "kube-worker02" {
    name = "kube-worker02"
    agent = 1

    sockets = 2
    cores   = 4
    memory  = 16384

    target_node = "ml350p"
    onboot      = false
    qemu_os     = "l26"
    full_clone  = false
    clone       = "SRV-Ubuntu-Focal"

    // Cloud-init
    ipconfig0   = "ip=10.8.0.3/24,gw=10.8.0.254"
    ciuser      = "ansible-op"
    sshkeys     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpEHNtySuF99P5t8RTO1TfZ4l3FynFErTqJQC6lM2TV ansible-op@ansible-server"
    nameserver  = "10.0.0.1"
    searchdomain = "lab.mylocal"


    network {
    // IP config 0
      bridge    = "vmbr150"
      firewall  = false
      link_down = false
      model     = "virtio"
      macaddr   = "E2:FC:D4:85:06:41"
    
    }

    disk {
    // ID 0
        type            = "scsi"
        storage         = "local-lvm"
        size            = "29900M"
        backup          = 0
    }
}

resource "proxmox_vm_qemu" "kube-nfs" {
    name = "kube-nfs"
    agent = 1

    sockets = 1
    cores   = 16
    memory  = 8192

    target_node = "ml350p"
    onboot      = false
    qemu_os     = "l26"
    full_clone  = false
    clone       = "SRV-Ubuntu-Focal-pved2"

    // Cloud-init
    ipconfig0   = "ip=10.8.0.200/24,gw=10.8.0.254"
    ciuser      = "ansible-op"
    sshkeys     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpEHNtySuF99P5t8RTO1TfZ4l3FynFErTqJQC6lM2TV ansible-op@ansible-server"
    nameserver  = "10.0.0.1"
    searchdomain = "lab.mylocal"

    network {
    // IP config 0
      bridge    = "vmbr150"
      firewall  = false
      link_down = false
      model     = "virtio"
      macaddr   = "86:24:D8:4D:3E:46"
    
    }


    # REMEMBER moving this later to pve-data2
    disk {
    // ID 0
        type            = "scsi"
        storage         = "pve-data2"
        size            = "408780M"
        backup          = 0
    }
    
}
