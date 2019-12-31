FROM ubuntu:18.04

RUN apt-get update && apt-get install -y qemu-system-arm qemu-utils expect

ADD ubuntu.img ./
ADD kernel ./
ADD initrd ./

RUN qemu-img resize ubuntu.img +6G

# Boot VM and install docker (takes a long time)
ADD setup.sh ./
RUN ./setup.sh

ENV PORT=2376
# Boot VM
CMD qemu-system-arm -M virt -m 1024 -cpu cortex-a15 -nographic -initrd initrd -kernel kernel -drive if=none,file=ubuntu.img,id=hd0 -device virtio-blk-device,drive=hd0 -net user,hostfwd=tcp::${PORT}-:2376 -net nic -append "root=/dev/vda1 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait"