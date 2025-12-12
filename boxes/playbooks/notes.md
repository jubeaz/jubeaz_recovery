# penbox


## solve packages

## to do
`sudo mount -t nfs -o vers=4 192.168.10.2:/srv/nfs/jubeaz /mnt/nfs/jubeaz`

### add sound
https://bbs.archlinux.org/viewtopic.php?id=300851
pipewire-xrdp.desktop    pulseaudio.desktop
systemctl --user restart wireplumber pipewire pipewire-pulse

sudo pacman -S alsa-utils alsa-plugins pipewire pipewire-alsa pipewire-pulse wireplumber


# windows
* NFS mounting does not work :  `New-PSdrive -PSProvider FileSystem -Name J -Root \\192.168.10.2\srv\nfs\jubeaz -Persist`