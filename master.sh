wget https://github.com/yh-raphael/Connected-Platform/raw/main/run_overlayfs.sh
wget https://github.com/yh-raphael/Connected-Platform/raw/main/run_dropbear.sh
wget https://github.com/yh-raphael/Connected-Platform/raw/main/dropbear.tgz

chmod +x run_overlayfs.sh
chmod +x run_dropbear.sh

sh run_overlayfs.sh
tar -zxvf dropbear.tgz -C /

/usr/sbin/dropbearkey -t rsa -f dropbear_rsa_host_key
passwd

dropbear -B -E -F -r dropbear_rsa_host_key &
