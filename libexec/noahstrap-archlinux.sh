#! /bin/bash

TARGET=$1
URL=$2
ARCHIVE=$(mktemp)

curl -o $ARCHIVE $URL
pv $ARCHIVE | gtar xf - -C $TARGET --strip-components=1

#
# Modify Arch Linux Userspace to do away with VFS
#
ln -s /dev/null $TARGET/dev/null

chmod u+w $TARGET/proc
mkdir $TARGET/proc/self/
echo "none / hfsplus" > $TARGET/proc/self/mounts

ln -fs ../proc/self/mounts $TARGET/etc/mtab
ln -fs /etc/resolv.conf $TARGET/etc/resolv.conf
ln -Fs /tmp $TARGET/tmp

echo archlinux is successfully installed into $TARGET

rm $ARCHIVE
