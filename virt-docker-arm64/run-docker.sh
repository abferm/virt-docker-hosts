#!/usr/bin/expect -f

# Wait enough (forever) until a long-time boot
set timeout -1

# Start the guest VM
spawn qemu-system-aarch64 -m 1024 -cpu cortex-a57 -M virt -pflash flash0.img -pflash flash1.img -drive if=none,file=ubuntu.img,id=hd0 -device virtio-blk-device,drive=hd0 -net user,hostfwd=tcp::2376-:2376 -net nic -nographic

expect "ubuntu login: "
send "root\n"

expect "Password: "
send "root\n"

# Run docker
expect "root@ubuntu:~# "
send "journalctl -f -u docker\n"

expect "root@ubuntu:~# "
send "poweroff\n"

expect "reboot: Power down"