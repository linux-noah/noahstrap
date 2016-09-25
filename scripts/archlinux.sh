#!/bin/sh

TARGET=$1

curl -O http://idylls.jp/noah-blob/arch.tar.lzma
tar xvf arch.tar.lzma -C $TARGET --strip-components=1

#
# Modify Arch Linux Userspace to do away with VFS
#
ln -s /dev/null $TARGET/dev/null

chmod u+w $TARGET/proc
mkdir $TARGET/proc/self/
echo "none / hfsplus" > $TARGET/proc/self/mounts

rm $TARGET/etc/mtab
ln -s ../proc/self/mounts $TARGET/etc/mtab

rm $TARGET/etc/resolv.conf
ln -s /etc/resolv.conf $TARGET/etc/resolv.conf

rm -rf $TARGET/tmp
ln -s /tmp $TARGET/tmp

rm $TARGET/etc/hostname

echo archlinux is successfully installed into $TARGET

rm arch.tar.lzma
