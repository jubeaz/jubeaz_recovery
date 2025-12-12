# install plugins
```
vagrant plugin install vagrant-libvirt
```

# nested virtualization

`kvm_adm` or `kvm_intel` module must be configured for nesting
```bash
cat /sys/module/kvm_amd/parameters/nested
cat /sys/module/kvm_intel/parameters/nested

modinfo kvm_amd | grep nested
```

if not enabled force it in `/etc/modprobe.d/kvm.conf`
```bash
options kvm_intel nested=1
# options kvm_amd nested=1
```

then vm cpu must be set to `host-passthrough`


# secure boot

* https://bbs.archlinux.org/viewtopic.php?id=275691
I retrieved them from https://packages.debian.org/sid/all/ovmf/download by
```bash
ar xv ovmf_2022.02-3_all.deb
tar -xvf data.tar.xz
sudo cp usr/share/OVMF/*4M* /usr/share/edk2-ovmf/x64# Install dir can be custom
```
Now secure boot is enabled in Windows and even emulated tpm works now. Anyway, I still don't understand why ArchLinux states it is disabled with the same settings. But I see it is disabled in bios so I can enable it from there, strange.


* CODE and VAR must be in a libvirt volume  and var file must be distinct for each guest.

## Vagrantfile
```ruby
require 'fileutils'

Vagrant.configure("2") do |config|
  ...
  efi_path='/var/lib/libvirt/images/efi'
  ...
  FileUtils.cp("../../ovmf/usr/share/OVMF/OVMF_CODE_4M.ms.fd", "#{efi_path}/OVMF_CODE_4M.ms.fd")
  box_defs.each do |box_def|
    FileUtils.cp("../../ovmf/usr/share/OVMF/OVMF_VARS_4M.ms.fd", "#{efi_path}/#{box_def[:bname]}_OVMF_VARS.4M.ms.fd")
    config.vm.define box_def[:bname] do |box|
      box.vm.provider "libvirt" do |box_provider|
        ...
        if box_def[:firmware] == "uefi"
          box_provider.nvram = "#{efi_path}/#{box_def[:bname]}_OVMF_VARS.4M.ms.fd"
          box_provider.loader = "#{efi_path}/OVMF_CODE_4M.ms.fd"
          ...
```


## Problem: 
```bash
-rw-r--r-- 1 libvirt-qemu libvirt-qemu  540672 Sep  5 01:40 nrunner_wld_dc_OVMF_VARS.4M.ms.fd
```

owner must be changed in order to be able to delete


## links
* https://vagrant-libvirt.github.io/vagrant-libvirt/
* https://www.labbott.name/blog/2016/09/15/secure-ish-boot-with-qemu/
* https://docs.fedoraproject.org/en-US/quick-docs/uefi-with-qemu/
* https://wiki.archlinux.org/title/Libvirt#UEFI_support
* https://www.linux-kvm.org/downloads/lersek/ovmf-whitepaper-c770f8c.txt
* https://github.com/quickemu-project/quickemu/issues/102#issuecomment-945024268