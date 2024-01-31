#!/bin/bash
for b in $(cat Vagrantfile  | grep bname: | cut -d'"' -f 2); do
    echo "vboxmanage controlvm $b  acpipowerbutton"
    vboxmanage controlvm $b  acpipowerbutton
done
sleep 1m
for b in $(cat Vagrantfile  | grep bname: | cut -d'"' -f 2); do
    echo "vboxmanage controlvm $b  poweroff"
    vboxmanage controlvm $b  poweroff
done
