# Packer-windows

Pack a base Windows 10 Education image with Packer and Hyper-V for Qemu/Openstack. Included applications:

- OpenSSH client + server
- Chocolatey
- VSCode
- Google Chrome
- Virtio-drivers
- 7zip
- Cloudbase-Init

## Prerequisite

1. Windows 10 with VT and Hyper-V enabled.
2. (Optional) Install Chocolatey. See: https://chocolatey.org/docs/installation
2. Powershell with OpenSSH client. If you are using Chocolatey: `choco install openssh`
3. Packer. `choco install packer`

## Usage

Define a `.pkrvars.hcl` file and set the Hyper-V network name. You can also override any variables as defined in `variables.pkr.hcl`.

Run:

```powershell
packer build -var-file="$variable.pkrvars.hcl" .
```