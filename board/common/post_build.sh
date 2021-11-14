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

# [openrc] /etc/conf.d
#   remove unnecessary openrc configs
openrc_config=${TARGET_DIR}/etc/conf.d
rm -f ${openrc_config}/consolefont
