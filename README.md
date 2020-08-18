# Windows-10-amd64

## Introduction

This repo contains Packer files for building Windows 10 base image for QEMU/OpenStack and for VirtualBox/Vagrant.

General requirement and instructions how to create and import created images to OpenStack/Vagrant are available in [wiki](https://gitlab.ics.muni.cz/muni-kypo-images/muni-kypo-images-wiki/-/wikis/image-packer).

The scripts will install all Windows updates – by default – during Windows Setup. To disable this functionality, comment out the `WITH WINDOWS UPDATES` section and uncomment the `WITHOUT WINDOWS UPDATES` section in `Autounattend.xml`.

SSH and WinRM is enabled, SSH login using password is disabled. ssh-key.pub is inserted for the vagrant user.

## Image for QEMU/OpenStack

For building this image for QEMU, additional [iso image with Windows drivers for QEMU](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso) must be downloaded. Use this command to download it: `wget -nv -nc https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso -O virtio-win.iso`.

There is one admin user account:

*  `vagrant` with password `vagrant`

## Image for VirtualBox/Vagrant

There is one admin user account:

*  `vagrant` with password `vagrant`

## Known issues and requested features

* See [issues](https://gitlab.ics.muni.cz/muni-kypo-images/windows-10-amd64/-/issues).
