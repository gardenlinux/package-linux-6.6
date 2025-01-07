# Kernel builds for Garden Linux

This repository contains the code for building the kernel in Garden Linux.
The build is based on [the debian kernel build](https://salsa.debian.org/kernel-team/linux).

Garden Linux includes the latest LTS version of the kernel.

## Components of this repository

`./config` contains Garden Linux specific build configuration for the kernel.

`./fixes-debian` contains patches for the debian build if needed.

`./upstream-patches` contains kernel patches that are not included in debian's kernel, but are part of the Garden Linux kernel.

`./prepare_source` contains a shell script that merges debian's kernel build repository with the upstream kernel sources.
