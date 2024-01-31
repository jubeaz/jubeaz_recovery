# vmware bug to set the ip
# see : https://github.com/hashicorp/vagrant/issues/5000#issuecomment-258209286

param ([String] $ip, [String] $mask, [String] $gw, [String] $ip_p, [String] $mask_p)
 netsh.exe int ipv4 set address "Ethernet 2" static $ip mask=$mask gateway=$gw 
 if ($ip_p -ne "None"){
	netsh.exe int ipv4 set address "Ethernet 3" static $ip_p mask=$mask_p 
}
route add 0.0.0.0 mask 0.0.0.0 $gw

