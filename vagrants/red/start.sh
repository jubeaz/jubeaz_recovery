#!/bin/bash
for b in $(cat Vagrantfile  | grep bname: | cut -d'"' -f 2); do
    echo "vboxmanage startvm $b --type headless"
    vboxmanage startvm $b --type headless
done