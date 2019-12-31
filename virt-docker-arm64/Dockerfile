FROM ubuntu:18.04

RUN apt-get update && apt-get install -y qemu-system-arm qemu-utils qemu-efi expect

# UEFI image setup
RUN dd if=/dev/zero of=flash0.img bs=1M count=64 && \
    dd if=/usr/share/qemu-efi/QEMU_EFI.fd of=flash0.img conv=notrunc && \
    dd if=/dev/zero of=flash1.img bs=1M count=64

ADD ubuntu.img ./

RUN qemu-img resize ubuntu.img +6G

# Boot VM and install docker (takes a long time)
ADD setup.sh ./
RUN ./setup.sh

ENV PORT=2376
# Boot VM
CMD qemu-system-aarch64 -m 1024 -cpu cortex-a57 -M virt -pflash flash0.img -pflash flash1.img -drive if=none,file=ubuntu.img,id=hd0 -device virtio-blk-device,drive=hd0 -net user,hostfwd=tcp::${PORT}-:2376 -net nic -nographic