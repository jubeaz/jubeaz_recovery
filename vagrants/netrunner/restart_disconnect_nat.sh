#!/bin/bash

vagrant halt
for b in $(cat Vagrantfile  | grep bname: | cut -d'"' -f 2); do
    echo "vboxmanage modifyvm $b --cableconnected1 off"
    vboxmanage modifyvm $b --cableconnected1 off
done

for b in $(cat Vagrantfile  | grep bname: | cut -d'"' -f 2); do
    echo "vboxmanage startvm $b --type headless"
    vboxmanage startvm $b --type headless
done