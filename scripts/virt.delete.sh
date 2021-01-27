name=$1

echo "Name: $1"

if [ -z "$name" ]; then
  echo "Invalid arguments"
  exit
fi

virsh destroy --domain $name
virsh undefine $name

rm -rf "~/virtuals/machines/${name}_*.qcow2"
