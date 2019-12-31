#!/usr/bin/expect -f

# Wait enough (forever) until a long-time boot
set timeout -1

# Start the guest VM
spawn qemu-system-aarch64 -m 1024 -cpu cortex-a57 -M virt -pflash flash0.img -pflash flash1.img -drive if=none,file=ubuntu.img,id=hd0 -device virtio-blk-device,drive=hd0 -net user,hostfwd=tcp::2376-:2376 -net nic -nographic

expect "ubuntu login: "
send "root\n"

expect "Password: "
send "root\n"

# Wait for cloud-init to finish
expect "Cloud-init * finished at"
send "\n"

# Install docker using official script
expect "root@ubuntu:~# "
send "curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh\n"

# Enable docker over tcp
expect "root@ubuntu:~# "
send "mkdir -p /etc/systemd/system/docker.service.d/ && echo '\[Service\]' >> /etc/systemd/system/docker.service.d/override.conf && echo 'ExecStart=' >> /etc/systemd/system/docker.service.d/override.conf && echo 'ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376' >> /etc/systemd/system/docker.service.d/override.conf\n"
expect "root@ubuntu:~# "
send "cat /etc/systemd/system/docker.service.d/override.conf\n"

expect "root@ubuntu:~# "
send "poweroff\n"

expect "reboot: Power down"