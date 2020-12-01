locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "hyperv-iso" "w10edu" {
  boot_wait            = "2m"
  cpus                 = 4
  disk_size            = 102400
  floppy_files         = [
    "${var.autounattend}",
    "./scripts/fixnetwork.ps1",
    "./scripts/chocolatey.ps1",
    "./scripts/openssh.ps1"
  ]
  headless             = "true"
  iso_checksum         = "sha256:deb930a6325b2fa2bd895872ddf088750a09107fb6d22dd7548b4be39d123aa1"
  iso_url              = "${var.iso_dir}/Windows20H2.iso"
  memory               = 4096
  output_directory     = "${var.output_dir}-${local.timestamp}"
  secondary_iso_images = ["${var.iso_dir}/${var.virtio}.iso"]
  shutdown_command     = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  ssh_password         = "packer"
  ssh_username         = "packer"
  ssh_wait_timeout     = "2h"
  switch_name          = "${var.network}"
  vm_name              = "win10edu"
}

build {
  description = "Windows 10 Education"

  sources = ["source.hyperv-iso.w10edu"]

  provisioner "windows-shell" {
    scripts = [
      "./scripts/uac-disable.bat",
      "./scripts/enable-rdp.bat"
    ]
  }
  provisioner "powershell" {
    scripts = [
      "./scripts/packages.ps1",
      "./scripts/cloudbase.ps1",
      "./scripts/sysprep.ps1"
    ]
  }
}
