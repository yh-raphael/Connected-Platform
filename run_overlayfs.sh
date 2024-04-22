#!/bin/bash

base="/mnt/lg/cmn_data/readwrite-debug"
upper="$base/upper"
work="$base/work"
target="/etc /usr /lib"

if [ ! -d $base ]
then
    for dirname in $target
    do
        mkdir -p $upper$dirname $work$dirname
    done
fi

for dirname in $target
do
    mount -t overlay -o rw,lowerdir=$dirname,upperdir=$upper$dirname,workdir=$work$dirname overlay $dirname
done

# overlayfs has a bug which cannot handle bind mount on lower dir
ROFSTABDIR="/etc/systemd/system/mount-readonly-volatile.d"
for i in $ROFSTABDIR/*.bind.fstab
do
    awk '$2 ~ "^/usr/" || $2 ~ "^/etc/" {system("mount --bind " $1 " " $2)}' $i
done
