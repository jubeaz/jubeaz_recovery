# vmware bug to set the ip
# see : https://github.com/hashicorp/vagrant/issues/5000#issuecomment-258209286

# eth0 = NAT
# eth1 = bridge
# eth 2 = internal

# sudo loakeys fr
# rm /etc/systemd/network/80-dhcp.network
sed -i '/Name=en.*/d' /etc/systemd/network/80-dhcp.network
sed -i 's/Name=eth.*/Name=eth0/g' /etc/systemd/network/80-dhcp.network
systemctl restart systemd-networkd
echo "Gateway=$3" >>  /etc/systemd/network/eth1.network
pacman -Syu --noconfirm
pacman -S --noconfirm python
#param ([String] $ip, [String] $mask, [String] $gw, [String] $ip_i, [String] $mask_i)
#netsh.exe int ipv4 set address "Ethernet 2" static $ip mask=$mask gateway=$gw 
#netsh.exe int ipv4 set address "Ethernet 3" static $ip_i mask=$mask_i 
#route add 0.0.0.0 mask 0.0.0.0 $gw
