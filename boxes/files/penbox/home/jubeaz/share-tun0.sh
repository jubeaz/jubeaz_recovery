sysctl net.ipv4.ip_forward

sudo sysctl -w net.ipv4.ip_forward=1
# echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/99-forward.conf

# NAT traffic through tun0
sudo iptables -t nat -A POSTROUTING  -o tun0 -j MASQUERADE # -s 192.168.1.0/24
sudo iptables -t nat -L -n -v

# allow forwarding from lan to tun0
sudo iptables -A FORWARD -i eth1 -o tun0 -j ACCEPT
# allow answer
sudo iptables -A FORWARD -i tun0 -o eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT

sudo iptables -L FORWARD -n -v
