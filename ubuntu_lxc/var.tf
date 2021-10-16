variable "token_secret" {
    description = "Proxmox API secret will be used to connect toy our promox instance."
    type        = string
}

## Host Variables ##


variable "computer_name" {
  description   = "A list of the hostnames that will be used for creation."
  type          = list(string)

  validation {
      condition = length(var.computer_name) > 0
      error_message = "Atleast fill in one computer name."
  } 
}

variable "description" {
    description = "Description of the container"
    type        = string 
  
}


variable "root_password" {
    description = "The root password."
    type = string
  
}

## Hardware ##

variable "cpu_cores" {
    description = "Amount of CPU cores the node will have."
    type = number
  
}

variable "memory" {
    description = "Amount of memory the node will have in MB."
    type = number
  
}


## Disk Variables ##

variable "disksize" {
    description = "Value of the size of the disk in 'G' Gigabite"
    type        = string
}



## Networking Variables ##

variable "bridge" {
    description     = "Value of what Vbridge device will be used for connection."
    type            = string
    default         = "vmbr99"
}


variable "mtu" {
    type        = string
    default     = "1500"
    description = "What MTU will be used for the configured container."

}

variable "ip" {
    type        = string
    description = "What address will be used for this machine IP or DHCP."
    default     = "dhcp"
}

variable "gw" {
    type        = string
    description = "What gateway will the machine use"
}


variable "vlan" {
    description = "Vlan tag for proxmox."
    type        = number
    default     =   50   
}