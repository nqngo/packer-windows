
# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

variable "autounattend" {
  type    = string
  default = "./answer_files/10/enterprise/Autounattend.xml"
}

variable "iso_checksum" {
  type    = string
  default = "SHA256:4767510FFB63CC6FE81BC81DDD377454751313185FFAE30B88DD597C8A24D371"
}

variable "iso_dir" {
  type    = string
  default = "./iso"
}

variable "iso_name" {
  type    = string
  default = "SW_DVD9_Win_Pro_10_20H2_64BIT_English_Pro_Ent_EDU_N_MLF_-2_X22-41520.iso"
}

variable "output_dir" {
  type    = string
  default = "./output"
}

locals {

  timestamp = formatdate("YYYYMMDDhhmm", timestamp())
}

source "hyperv-iso" "windows-10-bios" {
  boot_wait        = "4m"
  cpus             = 4
  disk_size        = 102400
  headless         = "true"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_dir}/${var.iso_name}"
  memory           = 4096
  output_directory = "${var.output_dir}-${local.timestamp}_w10e"
  shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  ssh_password     = "vagrant"
  ssh_username     = "Admin"
  ssh_wait_timeout = "2h"
  switch_name      = "Default Switch"
  vm_name          = "Windows_10_Enterprise"
  floppy_files     = [
    "${var.autounattend}",
    "./scripts/windows/fixnetwork.ps1",
    "./scripts/windows/uac-disable.ps1",
    "./scripts/windows/chocolatey.ps1",
    "./scripts/windows/openssh-install.ps1"
    ]
}

source "hyperv-iso" "windows-10-uefi" {
  boot_wait          = "4m"
  cpus               = 4
  disk_size          = 102400
  headless           = "true"
  iso_checksum       = "${var.iso_checksum}"
  iso_url            = "${var.iso_dir}/${var.iso_name}"
  memory             = 4096
  output_directory   = "${var.output_dir}-${local.timestamp}_w10e_uefi"
  shutdown_command   = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  ssh_password       = "vagrant"
  ssh_username       = "Admin"
  ssh_wait_timeout   = "2h"
  switch_name        = "Default Switch"
  vm_name            = "Windows_10_Enterprise_with_UEFI"
  generation         = 2
  enable_secure_boot = true
  cd_files         = [
    "${var.autounattend}",
    "./scripts/windows/fixnetwork.ps1",
    "./scripts/windows/uac-disable.ps1",
    "./scripts/windows/chocolatey.ps1",
    "./scripts/windows/openssh-install.ps1"
    ]
}


build {
  description = "Windows 10 Enterprise"

  sources = [
    "source.hyperv-iso.windows-10-uefi"
    ]

  provisioner "powershell" {
    scripts = [
      "./scripts/windows/rdp-enable.ps1",
      "./scripts/windows/virtio.ps1"
      ]
  }

}
