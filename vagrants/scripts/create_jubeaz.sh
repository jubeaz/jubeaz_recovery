/usr/bin/useradd --comment 'Jubeaz' --create-home --user-group jubeaz
#echo "${ANSIBLE_LOGIN}:${ANSIBLE_PASSWORD}" | /usr/bin/chpasswd
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/jubeaz
echo 'jubeaz ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/jubeaz
/usr/bin/chmod 0440 /etc/sudoers.d/jubeaz
/usr/bin/install --directory --owner=jubeaz --group=jubeaz --mode=0700 /home/jubeaz/.ssh
/usr/bin/install --owner=jubeaz --group=jubeaz --mode=0600 /tmp/authorized_keys /home/jubeaz/.ssh/authorized_keys
rm /tmp/authorized_keys