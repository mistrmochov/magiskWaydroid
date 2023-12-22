loope=true
a=""
while [ $loope = true ]
do
read -p "Do you really want to uninstall Magisk Delta from waydroid?(y/n)" a
if [ $a = "y" ]
then
loope=false
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
sudo systemctl stop waydroid-container.service
echo "Stopping waydroid!"
sleep 0.5
sudo rm -rf ~/.local/share/waydroid/data/adb/lspd
sudo rm -rf ~/.local/share/waydroid/data/adb/magisk
sudo rm -rf ~/.local/share/waydroid/data/adb/magisk.db
sudo rm -rf ~/.local/share/waydroid/data/adb/post-fs-data.d
sudo rm -rf ~/.local/share/waydroid/data/adb/service.d
sudo rm -rf ~/.local/share/waydroid/data/data/io.github.huskydg.magisk
sudo rm -rf ~/.local/share/waydroid/data/data/io.github.huskydg.magisk.png
sudo rm -rf /var/lib/waydroid/overlay/sbin/*
sudo rm -rf /var/lib/waydroid/overlay/system/etc/init/bootanim.rc
sudo gzip -dk /var/lib/waydroid/overlay/system/etc/init/bootanim.rc.gz
sudo rm -rf /var/lib/waydroid/overlay/system/etc/init/magisk
sudo rm -rf /var/lib/waydroid/overlay/system/addon.d
sudo rm -rf /var/lib/waydroid/overlay_rw/system/sbin/.magisk
sudo rm -rf /var/lib/waydroid/overlay_rw/system/system/etc/init/bootanim.rc
sudo rm -rf /var/lib/waydroid/overlay_rw/system/system/etc/init/bootanim.rc.gz
sudo rm -rf /var/lib/waydroid/overlay_rw/system/system/etc/init/magisk 
sudo rm -rf /var/lib/waydroid/overlay_rw/system/system/addon.d
sudo rm -rf /var/lib/waydroid/overlay_rw/vendor/etc/selinux/precompiled_sepolicy
sudo gzip -dk /var/lib/waydroid/overlay_rw/vendor/etc/selinux/precompiled_sepolicy.gz
sudo systemctl start waydroid-container.service
echo "Magisk removed, goodbye!"
else
echo "Aborting!"
fi
