# Fine!

System is almost ready to create new virtual environment.
However, there are few steps to do and rebooting is recommened after doing stuffs, yet.

## Sharing network interface (eth0) with virtual machines

You need to edit `/etc/network/interfaces` file to make default interface as bridge like following example:

> **Warning**
>
> `virt.create.sh` will attach br0 as network interface.

```
auto lo
iface lo inet loopback

auto br0
iface br0 inet dhcp
  bridge_ports eth0
  bridge_stp 0
```

Then check if interface on host system can get proper IP address with following command:

```sh
service networking restart
```

## Customizing `virt.create.sh` for another distros

Currently, `virt.create.sh` script is only for creating Alpine Linux distros and you need to tweak as you want.
