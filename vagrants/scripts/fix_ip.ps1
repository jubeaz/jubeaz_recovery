# vmware bug to set the ip
# see : https://github.com/hashicorp/vagrant/issues/5000#issuecomment-258209286

param ([String] $ip, [String] $mask, [String] $gw, [String] $ip_i, [String] $mask_i)
netsh.exe int ipv4 set address "Ethernet 2" static $ip mask=$mask gateway=$gw 
netsh.exe int ipv4 set address "Ethernet 3" static $ip_i mask=$mask_i 
route add 0.0.0.0 mask 0.0.0.0 $gw
