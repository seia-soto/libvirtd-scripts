# Seia-Soto/libvirtd-scripts

A small set of simple scripts to manage virtual environment on *Alpine Linux* for light users.

- Only uses about 100 to 150MB of memory on host machine
- Almost zero configuration

## Table of Contents

- [Requirements](#requirements)
- [Usage](#usage)

----

# Requirements

To use attached script files, you need to have:

- Alpine Linux 3.12 or higher version

# Usage

To use attached script files, you need to download and unpack it first.

> **Warning**
>
> Scripts are not the everything.

```sh
mkdir -p ~/virt.scripts
wget -qO- https://api.github.com/repos/Seia-Soto/libvirtd-scripts/tarball | tar xvz - -C ~/virt.scripts
```

## `virt.install.sh`

This script makes your system almost ready to deploy virtual machines.
While making system to run virtual machine, this script will create following folders:

- `~/scripts`, directory for this scritps set.
- `~/virtuals`
- `~/virtuals/images`, directory for CD image.
- `~/virtuals/machines`, directory for VM disks.

```sh
sh ~/scritps/virt.install.sh
```

## `virt.create.sh`

This script creates new Alpine Linux virtual machine on your system.
This will create an Alpine Linux virtual machine with the image downloaded when setting up new host with `virt.install.sh`.
The version is same with host machine.

```sh
sh ~/scritps/virt.create.sh [NAME] [CPU_CORES] [RAM_SIZE] [DISK_SIZE]
```

- `NAME`: (required) The name of the virtual machine.
- `CPU_CORES`: (required) The number of cores to virtualize.
- `RAM_SIZE`: (required) The max size of RAM to allocate in MB (dynamically allocated, max).
- `DISK_SIZE`: (required) The max size of qcow2 disk to allocate in GB (dynamically allocated, max).

### Notes

- This scripts will create virtual machine which attach `br0` as default network interface.

## `virt.delete.sh`

This script deletes virtual machine and its dependencies like boot disk things.

```sh
sh ~/scritps/virt.delete.sh [NAME]
```

- `NAME`: (required) The name of the virtual machine.

## `virt.add_volume.sh`

This script attaches external qcow2 disk to specific machine.

```sh
sh ~/scritps/virt.add_volume.sh [NAME] [SIZE] [PATH]
```

- `NAME`: (required) The name of the virtual machine.
- `SIZE`: (required) The number of cores to virtualize.
- `PATH`: (required) The path to attach volume, such as `vdb`, `vdc`, and `vdd`.

## `virt.get_osvars.sh`

This script runs a command `osinfo-query os`.
