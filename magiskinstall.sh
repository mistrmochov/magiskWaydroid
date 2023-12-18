#!/bin/bash
echo "Hi, welcome to simple Magisk Delta installer on Waydroid"
sleep 1
echo "NOTICE: This script copies preinstalled magisk files. I created this, because for lot of people the other scripts doesn't work!
I will also note, that this is not Kitsune Mask, but last release Magisk Delta!"
sleep 1
echo "Do you really want to install Magisk Delta on Waydroid?(y/n)"
read a
if [ $a = "y" ]
then
waydroid session stop
sudo waydroid container stop
sudo systemctl stop waydroid-container.service
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
sleep 0.5
echo "Downloading magisk"
wget https://magiskwaydroid.fra1.digitaloceanspaces.com/magisk.tar.gz
sleep 0.5
echo "Unpacking magisk"
sudo tar -xf magisk.tar.gz
sleep 0.5
echo "Copying files!"
sudo cp -r magisk/overlay /var/lib/waydroid/
sudo cp -r magisk/overlay_rw /var/lib/waydroid/
sudo cp -r magisk/data ~/.local/share/waydroid/
sleep 0.5
sudo rm -rf magisk magisk.tar.gz
sudo systemctl start waydroid-container.service
echo "Starting waydroid-container.service"
sleep 0.5
echo "Installation has finished, enjoy Magisk!"
elif [ $a = "n" ]
then
echo "Aborting!"
mkdir no
else
echo "Aboring!"
fi
