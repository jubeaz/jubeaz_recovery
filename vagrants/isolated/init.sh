# vmware bug to set the ip
# see : https://github.com/hashicorp/vagrant/issues/5000#issuecomment-258209286

# eth0 = NAT
# eth1 = bridge
# eth 2 = internal

sed -i '/Name=en.*/d' /etc/systemd/network/80-dhcp.network
sed -i 's/Name=eth.*/Name=eth0/g' /etc/systemd/network/80-dhcp.network
systemctl restart systemd-networkd
echo "Gateway=$1" >>  /etc/systemd/network/eth1.network
pacman -Syu --noconfirm
pacman -S --noconfirm reflector
#
reflector --country France,Germany --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

#/usr/bin/systemctl enable reflector.service
#/usr/bin/systemctl start reflector.service
#/usr/bin/systemctl enable reflector.timer


#pacman -S --noconfirm base-devel linux-lts linux-firmware vim git python rng-tools lsof bash-completion openssh  pulseaudio-alsa
pacman -S --noconfirm base-devel vim git python rng-tools openssh 


## #######################################
## sshd
## #######################################

  /usr/bin/sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
  /usr/bin/sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
  /usr/bin/echo 'PubkeyAcceptedKeyTypes=+ssh-rsa' >> /etc/ssh/sshd_config
# PubkeyAcceptedKeyTypes=+ssh-rsa

  /usr/bin/systemctl enable sshd.service
  /usr/bin/systemctl enable rngd

  rm  -f /etc/ssh/*.key
  rm  -f /etc/ssh/*_key
  ssh-keygen -A

# #######################################
# jubeaz
# #######################################

  /usr/bin/useradd --comment 'jubeaz' --create-home --user-group jubeaz
  /usr/bin/echo "jubeaz:jubeaz" | /usr/bin/chpasswd
  /usr/bin/echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/jubeaz
  /usr/bin/echo 'jubeaz ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/jubeaz
  /usr/bin/chmod 0440 /etc/sudoers.d/jubeaz
  /usr/bin/install --directory --owner=jubeaz --group=jubeaz --mode=0700 /home/jubeaz/.ssh
  /usr/bin/install --owner=jubeaz --group=jubeaz --mode=0600 /tmp/authorized_keys /home/jubeaz/.ssh/authorized_keys