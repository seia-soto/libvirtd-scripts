name=$1
disk=$2
dev=$3

echo "Name: $1"
echo "Size: $2 MB"
echo "DevPath: /dev/$3"

if [ -z "$name" ] || [ -z "$disk" ] || [ -z "$dev" ]; then
  echo "Invalid arguments"
  exit
fi

disk_source="${HOME}/virtuals/machines/${name}_${dev}_${disk}M.qcow2"

echo "Path: ${disk_source}"

qemu-img create -f qcow2 $disk_source "${disk}M"
virsh attach-disk --domain $name --source $disk_source --persistent --target $dev
