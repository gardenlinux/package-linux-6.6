# Kernel builds for Garden Linux

This repository contains the code for building the [kernel](https://www.kernel.org) in Garden Linux.
The build is based on [the debian kernel build](https://salsa.debian.org/kernel-team/linux).

Garden Linux includes the latest LTS version of the kernel.

## Components of this repository

`./config` contains Garden Linux specific build configuration for the kernel.

`./fixes-debian` contains patches for the debian build if needed.
We apply all patches from debian by default.
In some cases, we need to make changes to those to get a working build.

`./upstream-patches` contains kernel patches that are not included in debian's kernel, but are part of the Garden Linux kernel.

`./prepare_source` contains a shell script that merges debian's kernel build repository with the upstream kernel sources.

`./update-kernel.py` contains a script which helps keeping up with patch releases of the LTS kernel version.

`.github/workflows/pr-if-new-kernel.yml` contains the workflow to create new PRs based on `./update-kernel.py` if new patch versions of the LTS kernel are available.

`.github/workflows/build.yml` contains the workflow to build and release the kernel binaries.
