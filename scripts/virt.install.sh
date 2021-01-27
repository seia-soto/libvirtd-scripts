echo Initiating script

distro=$(grep "^NAME" /etc/os-release | sed "s/.*\=//" | sed "s/\"//g")
version=$(cat /etc/alpine-release)
user=$(whoami)

cat << EOF
# Seia-Soto/libvirtd-scripts

Every commands are referenced from Alpine Linux wiki.
  - https://wiki.alpinelinux.org/wiki/KVM
  - https://typed.sh/alpinelinuxeseo-libvirtro-vm-host-gucughagi/

This script will install Seia-Soto/libvirtd-scripts and extract things to `~/`.

----
<Current system>

Distro: ${distro}
Version: ${version}
User: ${user}
----

EOF

echo - Validating user
if [ $user != "root" ]; then
  echo ERROR: You need to run this script as root!
fi

echo - Validating distro
if [ $distro != *"Alpine Linux"*  ] || [ $(printf "${version}\n3.12.0" | sort -V | head -n 1) != "3.12.0" ]; then
  echo ERROR: Currently, only Alpine Linux version 3.12.0 or higher is supported on this script!
fi

echo - Updating packages
apk update
apk upgrade

echo - Installing required packages
apk add util-linux sudo libvirt-daemon qemu-img qemu-system-x86_64 virt-install cdrkit libosinfo bridge

echo - Adding libvirtd to boot service
rc-update add libvirtd boot

echo - Enabling tun module
modprobe tun
echo tun | sudo tee -a /etc/modules

echo - Making iptables to accept DHCP lease signals after boot
rc-update add local

cat >> /etc/local.d/iptables_dhcp_kvm.start << EOM
echo 0 > /proc/sys/net/bridge/bridge-nf-call-arptables
echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables
echo 0 > /proc/sys/net/bridge/bridge-nf-call-ip6tables

iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

exit 0
EOM
cat >> /etc/local.d/iptables_dhcp_kvm.stop << EOM
exit 0
EOM

chmod +x /etc/local.d/iptables_dhcp_kvm.*

echo - Creating required folders
mkdir -p ~/scripts
mkdir -p ~/virtuals/machines
mkdir -p ~/virtuals/images

echo "- Downloading Alpine Linux distro ${version}"
echo "*~/virtuals/images/alpine-virt-lastinst-x86_64.iso"
wget "https://dl-cdn.alpinelinux.org/alpine/v3.13/releases/x86_64/alpine-virt-${version}-x86_64.iso" -O ~/virtuals/images/alpine-virt-lastinst-x86_64.iso

cat ~/scripts/virt.install.postinstall.md
