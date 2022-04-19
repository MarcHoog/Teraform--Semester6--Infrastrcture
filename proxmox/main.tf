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

resource "proxmox_vm_qemu" "ansible" {
    name        = "ansible"
    agent       = 1
    target_node = "ml350p"
    onboot      = false
    qemu_os     = "l26"
    full_clone  = false

    // CPU
    sockets = 2
    cores   = 4
    memory  = 4096
    
    // CLOUD-INIT
    ipconfig0   = "ip=10.0.0.1/24,gw=10.0.0.254"
    ciuser      = "root"
    sshkeys     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9PdGQSxLdItzCZ/NNo+Pk2Hut7YKTaJiOvnPpJT0Td5CW3JrggnNJYF4+WmCSQ7XYlYw+Z6yV8sZu6ox1SoIYp/zvAbiMRqhKavj+mJ6i/wAx44sPeSxW/+/+Bl3aW66OsxGkX7JhmjzmuftQ7XAxOBYJNp8r1RTKKMq2jS7tvHevyC+6fjSbl/2fsyXjPPpBuGZ9wGDIWbLr/AHldulkOU+mmyxYyeW2EuBgGEB4qaybEf6aPkYP77pMMpbYnncqWzO02pn9IiE1+UtFMDDgwRw1aNV8RhfE5GRB9TA1poP27tfwvPq51w8MfKfAVFIPhuw6oNNOD2HWUyz3JkjAltSEjjUA4a3M3NFbWqIiY5tHws+Er2s0lsQSZwUrPJ2d0bXrTBJqLrc91R2CCKmou0Lki3gAeGHjABLNeJvaIf/IERuq9iEgTufHL7pWvKR34k+h+LjVL+KrUfW5WklfY9xkECUTp44wyInhc9RfZ2hsTkbkGr+FjnPkyfG5GrE= marchoogendoorn@Air-van-marc"


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

resource "proxmox_vm_qemu" "test-vm" {

    name        = "test-vm"
    agent       = 1
    target_node = "ml350p"
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

resource "proxmox_vm_qemu" "kube-master" {
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
    nameserver  = "10.8.0.254"

    network {
    // IP config 0
      bridge    = "vmbr150"
      firewall  = false
      link_down = false
      model     = "virtio"
    
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
    nameserver  = "10.8.0.254"

    network {
    // IP config 0
      bridge    = "vmbr150"
      firewall  = false
      link_down = false
      model     = "virtio"
    
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
    nameserver  = "10.8.0.254"

    network {
    // IP config 0
      bridge    = "vmbr150"
      firewall  = false
      link_down = false
      model     = "virtio"
    
    }

    disk {
    // ID 0
        type            = "scsi"
        storage         = "local-lvm"
        size            = "29900M"
        backup          = 0
    }
}

/*
resource "proxmox_vm_qemu" "storage" {
    name = "storage-server"
    agent = 1

    sockets = 2
    cores   = 8
    memory  = 8192

    target_node = "ml350p"
    onboot      = false
    qemu_os     = "l26"
    full_clone  = false
    clone       = "SRV-Ubuntu-Focal"

    // Cloud-init
    ipconfig0   = "ip=10.8.0.253/24,gw=10.8.0.254"
    ciuser      = "ansible-op"
    sshkeys     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpEHNtySuF99P5t8RTO1TfZ4l3FynFErTqJQC6lM2TV ansible-op@ansible-server"
    nameserver  = "10.8.0.254"

    network {
    // IP config 0
      bridge    = "vmbr150"
      firewall  = false
      link_down = false
      model     = "virtio"
    
    }

    disk {
    // ID 0
        type            = "scsi"
        storage         = "local-lvm"
        size            = "200G"
        backup          = 0
    }

    
}
*/

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
