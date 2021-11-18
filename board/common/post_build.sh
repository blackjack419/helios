#!/bin/sh
# Called after Buildroot builds all the selected software, but before
# the rootfs images are assemebled. Runs with the main Buildroot tree
# as the current working directory.
#
# The path to the target filesystem is passed as the first argument
# to this script.
#
# You can remove or modify any file in your target filesystem. However,
# you should use this feature with care. Whenever you find that a
# certain package generates wrong or unneeded files, you should fix
# that package rather than work around it with this post-build cleanup.

# Our buildroot config should have the HELIOS_VERSION passed as the first
# additional argument in the BR2_ROOTFS_POST_SCRIP_ARGS
VERSION_STRING="${2}"

# Remove undesired folders from default skeleton
rm -rf ${TARGET_DIR}/opt
rm -rf ${TARGET_DIR}/media

# [openrc] /etc/runlevels
#   remove unwanted openrc startup scripts
openrc_runtime=${TARGET_DIR}/etc/runlevels
rm -f ${openrc_runtime}/boot/binfmt
rm -f ${openrc_runtime}/boot/termencoding
rm -f ${openrc_runtime}/boot/save-termencoding
rm -f ${openrc_runtime}/default/netmount
rm -rf ${openrc_runtime}/nonetwork

# [openrc] /etc/conf.d
#   remove or modify openrc configs
openrc_config=${TARGET_DIR}/etc/conf.d
rm -f ${openrc_config}/consolefont
#   synchronize openRC hostname with /etc/hostname
syshostname="$(cat ${TARGET_DIR}/etc/hostname)"
if [ -n ${syshostname} ]; then
	sed -i "s/hostname=.*/hostname=\"${syshostname}\"/g" ${openrc_config}/hostname
fi

# [openrc] /etc/init.d
#    remove unneeded init scripts
openrc_bin=${TARGET_DIR}/etc/init.d
rm -f ${openrc_bin}/save-termencoding
rm -f ${openrc_bin}/termencoding
rm -f ${openrc_bin}/consolefont
rm -f ${openrc_bin}/binfmt
rm -f ${openrc_bin}/netmount
rm -f ${openrc_bin}/numlock
rm -f ${openrc_bin}/osclock
rm -f ${openrc_bin}/net-online

# [metadata] /lib/os-release
#   customize os-release
sed -i -e "s/^NAME=.*/NAME=HeliOS/g" \
       -e "s/^VERSION=.*/VERSION=${VERSION_STRING}/g" \
       -e "s/^PRETTY_NAME=.*/PRETTY_NAME=\"HeliOS Alpha ${VERSION_STRING}\"/g" \
	${TARGET_DIR}/lib/os-release
