#!/bin/bash
for b in $(cat Vagrantfile  | grep bname: | cut -d'"' -f 2); do
    echo "vboxmanage modifyvm $b --cableconnected2 off"
    vboxmanage modifyvm $b --cableconnected2 off
done
