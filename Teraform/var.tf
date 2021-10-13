variable "token_secret" {
    description = "Proxmox API secret will be used to connect toy our promox instance."
    type        = string
}

variable "computer_name" {
  description   = "A list of the hostnames that will be used for creation."
  type          = list(string)
  default = [ "LXC-Terraform" ]

  validation {
      condition = length(var.computer_name) > 0
      error_message = "Atleast fill in one computer name."
  } 
}

variable "networking_bridge" {
    description     = "Value of what Vbridge device will be used for connection."
    type            = string

    validation {
        condition       = tostring(var.networking_bridge) == "Vnet500"
        error_message   = "The bridge value must be a valid bridge, check proxmox for more information."
    }
}

variable "networking_mtu" {
  description = "What MTU will be used for the configured container."
  type        = string
}

variable "networking_ip" {
    description = "What address will be used for this machine IP or DHCP."
    type        = string
    default     = "dhcp"
}