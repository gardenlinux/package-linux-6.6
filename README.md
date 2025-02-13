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


## Backports 

The main branch is always on latest Long term supported Linux version defined at kernel.org. 

We maintain also older supported kernel versions, if they are required by supported Garden Linux versions.
To see what Garden Linux versions are currently supported, please check out the [Active and Next Release](https://github.com/gardenlinux/gardenlinux?tab=readme-ov-file#active-and-next-releases) section in gardenlinux/gardenlinux repository. 

Any kernel version that we need to maintain other than the latest LTS in main, are maintained in `maint-<MAJOR.MINOR>` branches (e.g. maint-6.6).
Actual backport releases need to branch of from the respective `maint-<MAJOR.MINOR>` branch and include the corresponding `.container` file for target backport.

> [!Tip]
> You can find out the correct `.container` file by copying it from the corresponding tag of the https://github.com/gardenlinux/repo branch, for example [1443.0](https://github.com/gardenlinux/repo/blob/1443.0/.container)


## Automated kernel patch level upgrades 

A scheduled workflow scans a list of configured branches [see](https://github.com/gardenlinux/package-linux/blob/main/.github/workflows/pr-if-new-kernel.yml#L12), and bumps the patchlevel of the version defined in the prepare_source file.
The automation creates a PR if a new patchlevel is available.

> [!Hint]
> This is done via the [update-kernel.py](https://github.com/gardenlinux/package-linux/blob/main/update-kernel.py) tool



