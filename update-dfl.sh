#!/usr/bin/env bash
set -exuo pipefail

workingDir="$(readlink -f "$(pwd)")"
srcDir="linux-dfl"
DFL_BRANCH="fpga-ofs-dev-6.6-lts"
KERNEL_VERSION="6.6.17"
OUTPUT_PATCH_FOLDER="${DFL_BRANCH}-patches"

if [[ ! -d ${srcDir} ]]; then
    echo '### Cloning repos. This may take some minutes...'
    git clone https://github.com/OPAE/linux-dfl.git "${srcDir}"
    pushd "${srcDir}"
    git remote add linux-stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
    popd
else
   pushd "${srcDir}"
   git fetch
   git pull
   git config pull.rebase true
   git pull linux-stable "v${KERNEL_VERSION}"
   popd
fi


set -x
pushd "${srcDir}"
echo '### Creating patches ...'
git fetch -t linux-stable
git checkout "${DFL_BRANCH}"
git format-patch --no-signature -N -o "${OUTPUT_PATCH_FOLDER}" --first-parent --no-merges "v${KERNEL_VERSION}..${DFL_BRANCH}"
mv "${OUTPUT_PATCH_FOLDER}" "${workingDir}"
echo "### Done. Please verify patches in ${OUTPUT_PATCH_FOLDER}, and place them manually to debian/patches/gardenlinux/00-dfl_support"
popd

rm -rf ${workingDir}/debian/patches/gardenlinux/00-dfl_support
mv ${OUTPUT_PATCH_FOLDER} debian/patches/gardenlinux/00-dfl_support

grep -rni "+++ b" | cut -d':' -f3 | sort | uniq > ${workingDir}/dfl-changed-files.list
echo "List of modified files in ${workingDir}/dfl-changed-files.list"

