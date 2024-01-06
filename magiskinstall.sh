#!/bin/bash
loope=false
a=""
SYSTEM=$(cat /var/lib/waydroid/waydroid.cfg | grep images_path | cut -d' ' -f 3)/system.img
VENDOR=$(cat /var/lib/waydroid/waydroid.cfg | grep images_path | cut -d' ' -f 3)/vendor.img
ARCH=$(cat /var/lib/waydroid/waydroid.cfg | grep arch | cut -d' ' -f 3)
clear
echo "Hi, welcome to simple Magisk Delta installer on Waydroid"
sleep 1
echo "NOTICE: This script copies preinstalled magisk files. I created this, because for lot of people the other scripts doesn't work!
I will also note, that this is not Kitsune Mask, but last release Magisk Delta!"
sleep 1
if [ $ARCH = "x86_64" ]
then
loope=true
else
echo "Sorry but," $ARCH "is not supported yet, by this script!"
loope=false
a="n"
fi
while [ $loope = true ]
do
read -p "Do you really want to install Magisk Delta on Waydroid? (y/n):" a
if [ $a = "y" ]
then
loope=false
touch init.txt
ps -p 1 -o command > init.txt
elif [ $a = "n" ]
then
loope=false
else
clear
loope=true
echo "No option selected, try again!"
fi
done
if [ $a = "y" ]
then
waydroid session stop
sudo waydroid container stop
if grep -Fxq "runit" init.txt
then
sudo sv down waydroid-container
else
sudo systemctl stop waydroid-container.service
fi
echo "Stopping waydroid!"
sleep 0.5
echo "Removing any previous installation of magisk, excluding modules!"
sudo rm -rf ~/.local/share/waydroid/data/adb/lspd
sudo rm -rf ~/.local/share/waydroid/data/adb/magisk
sudo rm -rf ~/.local/share/waydroid/data/adb/magisk.db
sudo rm -rf ~/.local/share/waydroid/data/adb/post-fs-data.d
sudo rm -rf ~/.local/share/waydroid/data/adb/service.d
sudo rm -rf ~/.local/share/waydroid/data/data/io.github.huskydg.magisk
sudo rm -rf ~/.local/share/waydroid/data/data/io.github.huskydg.magisk.png
sudo rm -rf /var/lib/waydroid/overlay/sbin/*
sudo rm -rf /var/lib/waydroid/overlay/system/etc/init/bootanim.rc
sudo rm -rf /var/lib/waydroid/overlay/system/etc/init/bootanim.rc.gz
sudo rm -rf /var/lib/waydroid/overlay/system/etc/init/magisk
sudo rm -rf /var/lib/waydroid/overlay/system/addon.d
sudo rm -rf /var/lib/waydroid/overlay_rw/system/sbin/.magisk
sudo rm -rf /var/lib/waydroid/overlay_rw/system/system/etc/init/bootanim.rc
sudo rm -rf /var/lib/waydroid/overlay_rw/system/system/etc/init/bootanim.rc.gz
sudo rm -rf /var/lib/waydroid/overlay_rw/system/system/etc/init/magisk
sudo rm -rf /var/lib/waydroid/overlay_rw/system/system/addon.d
sudo rm -rf /var/lib/waydroid/overlay_rw/vendor/etc/selinux/*
sleep 0.5
echo "Resizing images"
sudo e2fsck -yf $SYSTEM
sudo resize2fs $SYSTEM 3G
sudo e2fsck -yf $VENDOR
sudo resize2fs $VENDOR 1G
sleep 0.5
echo "Downloading magisk"
wget -q https://magiskwaydroid.fra1.digitaloceanspaces.com/magisk0.7.tar.gz -O magisk.tar.gz
sleep 0.5
echo "Unpacking magisk"
sudo tar -xf magisk.tar.gz
sleep 0.5
echo "Copying files!"
sudo cp -r magisk/overlay /var/lib/waydroid/
sudo cp -r magisk/overlay_rw /var/lib/waydroid/
sudo cp -r magisk/data ~/.local/share/waydroid/
sleep 0.5
sudo rm -rf magisk magisk.tar.gz magisk0.7.tar.gz
if grep -Fxq "runit" init.txt
then
sudo sv up waydroid-container
else
sudo systemctl start waydroid-container.service
fi
echo "Starting waydroid-container.service"
sleep 0.5
echo "Installation has finished, now start up waydroid and after waydroid fully boots and If magisk was successfully installed then just simply reboot your Waydroid or proceed direct install to system through Magisk app. Enjoy Magisk <3"
rm -rf init.txt
elif [ $a = "n" ]
then
echo "Aborting!"
fi
