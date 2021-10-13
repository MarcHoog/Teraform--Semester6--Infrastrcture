variable "computer_name" {
  description   = "A list of the hostnames that will be used for creation."
  type          = list(string)
  default       = ["test1","test2"] 
}


variable "bridge" {
    description     = "Value of what Vbridge device will be used for connection."
    type            = string

    validation {
        condition       = string(var.bridge) == "Vnet500"
        error_message   = "The bridge value must be a valid bridge, check proxmox for more information."
    }
}