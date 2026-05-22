echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
sudo ip route add default via 192.168.1.1 dev eth1

sudo tee /etc/apt/sources.list <<EOF
deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
deb http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware
EOF
sudo apt update
sudo apt install usbutils iwd iw firmware-mediatek firmware-misc-nonfree wireless-regdb
sudo modprobe -r mt76x0u && sudo modprobe mt76x0u