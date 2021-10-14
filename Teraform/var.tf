variable "token_secret" {
    description = "Proxmox API secret will be used to connect toy our promox instance."
    type        = string
}



##################
# Host Variables #
##################


variable "computer_name" {
  description   = "A list of the hostnames that will be used for creation."
  type          = list(string)

  validation {
      condition = length(var.computer_name) > 0
      error_message = "Atleast fill in one computer name."
  } 
}


variable "root_password" {
    description = "The root password."
    type = string
  
}

##################
# Disk Variables #
##################

variable "disksize" {
    description = "Value of the size of the disk in 'G' Gigabite"
    type        = string
}



########################
# Networking Variables #
########################

variable "bridge" {
    description     = "Value of what Vbridge device will be used for connection."
    type            = string

    validation {
        condition       = tostring(var.bridge) == "Vnet500"
        error_message   = "The bridge value must be a valid bridge, check proxmox for more information."
    }
}


#variable "mtu" {
#  description = "What MTU will be used for the configured container."
#  type        = string
#}

variable "ip" {
    description = "What address will be used for this machine IP or DHCP."
    type        = string
    default     = "dhcp"
}