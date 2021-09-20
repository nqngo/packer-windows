# Packer Windows

Build a Windows base image with Packer + Powershell + Hyper-V.

## Prerequisite

This repo requires the following CLI tool in Powershell.

```powershell
packer
oscdimg (from `windows-adk`)
```

If you are using [Chocolatey](https://chocolatey.org/), you can install the above dependencies with:

```powershell
choco install ./chocolatey.config
```

## Build Hyper-V images

If you just start cloning the repo, initialise the `packer_cache`:

```powershell
packer init .
```

To build the image, run the following in an elevated Powershell:

```powershell
packer build .
```

You can build only a specific image by explicitly naming the pipeline:

```powershell
packer build windows10-enterprise.pkr.hcl
```