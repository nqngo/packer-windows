# Variables file for windows 10 build

variable "autounattend" {
  type        = string
  description = "Unattended Windows answer files location"
  default     = "./answers/w10/Autounattend.xml"
}

variable "driver_dir" {
  type        = string
  description = "VirtIO driver ISO location. This is needed for the VM to run in qemu/libvirt." 
  default     = "./iso"
}

variable "http_dir" {
  type    = string
  default = "./iso"
}

variable "iso_dir" {
  type    = string
  default = "./iso"
}

variable "output_dir" {
  type    = string
  default = "./output"
}

variable "virtio" {
  type    = string
  default = "virtio-win-0.1.185"
}

variable "network" {
  type        = string
  description = "The network name on HyperV switch."
}