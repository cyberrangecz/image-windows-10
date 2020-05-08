# Windows-10-amd64

## Introduction

This repo contains Packer files for building Windows 10 base image for QEMU/OpenStack and for VirtualBox/Vagrant.

General requirement and instructions how to create and import created images to OpenStack/Vagrant are available in [wiki](https://gitlab.ics.muni.cz/CSIRT-MU/DEVOPS/devops-group/-/wikis/image-packer).

## Image for QEMU/OpenStack

For building this image for QEMU, additional [iso image with Windows drivers for QEMU](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso) must be downloaded. Use this command to download it: `wget -nv -nc https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso -O virtio-win.iso`.

There is one admin user account:

*  `vagrant` with password `vagrant`

## Image for VirtualBox/Vagrant

There is one admin user account:

*  `vagrant` with password `vagrant`

## Known issues and requested features

* See [issues](https://gitlab.ics.muni.cz/CSIRT-MU/DEVOPS/win-10-amd64/-/issues).
