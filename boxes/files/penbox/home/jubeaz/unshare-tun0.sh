# Disable forwarding from lan to tun0
sudo iptables -D FORWARD -i eth1 -o tun0 -j ACCEPT
sudo iptables -D FORWARD tun0 -o eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -L FORWARD -n -v

# Disable NAT traffic through tun0
sudo iptables -t nat -D POSTROUTING -o tun0 -j MASQUERADE # -s 192.168.1.0/24
sudo iptables -t nat -L -n -v

sudo sysctl -w net.ipv4.ip_forward=1
sysctl net.ipv4.ip_forward
