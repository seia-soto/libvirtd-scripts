name=$1
cores=$2
ram=$3

echo "Name: $1"
echo "Cores: 1 CPU $2 vCores"
echo "Ram: $3 MB"

if [ -z "$name" ] || [ -z "$cores" ] || [ -z "$ram" ]; then
  echo "Invalid arguments"
  exit
fi

virt-install \
  -n $name \
  --ram $ram \
  --vcpus=$cores \
  --cpu host \
  --cdrom="~/virtuals/images/alpine-virt-lastinst-x86_64.iso" \
  --os-type=linux \
  --os-variant=alpinelinux3.13 \
  --disk path="~/virtuals/machines/${name}_boot.qcow2,size=32,bus=virtio,format=qcow2" \
  --network bridge=br0 \
  --accelerate \
  --nographics \
  --debug
virsh console $name
