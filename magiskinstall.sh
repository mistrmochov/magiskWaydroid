#!/bin/bash
loope=false
a=""
SYSTEM=$(cat /var/lib/waydroid/waydroid.cfg | grep images_path | cut -d' ' -f 3)/system.img
VENDOR=$(cat /var/lib/waydroid/waydroid.cfg | grep images_path | cut -d' ' -f 3)/vendor.img
ARCH=$(cat /var/lib/waydroid/waydroid.cfg | grep arch | cut -d' ' -f 3)
clear
function prep() {
    echo "Hi, welcome to simple Magisk Delta installer on Waydroid"
    sleep 0.3
    if [ $ARCH = "x86_64" ]; then
        loope=true
    elif [ $ARCH = "arm64" ]; then
        loope=true
    else
        echo "Sorry but," $ARCH "is not supported yet, by this script!"
        loope=false
        a="3"
    fi
}

function promt() {
    while [ $loope = true ]; do
        echo "Do you want to install Magisk Delta on Waydroid? (1)"
        echo "Do you want to install Magisk Delta preinstalled with LSposed and Builtin busybox? (2)"
        echo "Abort (3)"
        read -p "Make a choice (choose number):" a
        if [[ $ARCH = "arm64" && $a = "2" ]]; then
            echo "Sorry the option with modules is only for x86_64 arch, proceeding with normal Magisk Delta install!"
            a="1"
        else
            echo "Selected option: $a"
            sleep 0.3
        fi
        if [[ $a = "1" || $a = "2" ]]; then
            loope=false
            touch init.txt
            ps -p 1 -o command >init.txt
        elif [ $a = "3" ]; then
            loope=false
        else
            clear
            loope=true
            echo "No option selected, try again!"
        fi
    done
}

function waydroid_down() {
    echo "Stopping waydroid!"
    waydroid session stop
    sudo waydroid container stop
    if grep -Fxq "runit" init.txt; then
        sudo sv down waydroid-container
    else
        sudo systemctl stop waydroid-container.service
    fi
}

function rm_magisk() {
    echo "Removing any previous installation of Magisk"
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
}

function resize_images() {
    echo "Resizing images"
    sudo e2fsck -yf $SYSTEM
    sudo resize2fs $SYSTEM 3G
    sudo e2fsck -yf $VENDOR
    sudo resize2fs $VENDOR 1G
}

function install_magisk() {
    echo "Downloading magisk"
    if [ $ARCH = "arm64" ]; then
        wget -q https://mistrmochov.blob.core.windows.net/magiskwaydroid/magiskarm64_0.8.tar.gz -O magisk.tar.gz
    else
        wget -q https://mistrmochov.blob.core.windows.net/magiskwaydroid/magisk_0.8.4.tar.gz -O magisk.tar.gz
    fi
    sleep 0.3
    if [ $a = "2" ]; then
        echo "Unpacking magisk with modules!"
    else
        echo "Unpacking magisk"
    fi
    sudo tar -xf magisk.tar.gz
    sleep 0.3
    echo "Copying files!"
    if [ $ARCH = "x86_64" ]; then
        sudo cp -r magisk/overlay /var/lib/waydroid/
        sudo cp -r magisk/overlay_rw /var/lib/waydroid/
        if [ $a = "2" ]; then
            sudo cp -r magisk/data_modules/* ~/.local/share/waydroid/data/
        else
            sudo cp -r magisk/data ~/.local/share/waydroid/
        fi
    else
        sudo cp -r magisk/overlay /var/lib/waydroid/
        sudo cp -r magisk/data ~/.local/share/waydroid/
    fi
    sleep 0.3
    sudo rm -rf magisk magisk.tar.gz
}

function waydroid_up() {
    echo "Starting waydroid-container.service"
    if grep -Fxq "runit" init.txt; then
        sudo sv up waydroid-container
    else
        sudo systemctl start waydroid-container.service
    fi
}

function install() {
    if [[ $a = "1" || $a = "2" ]]; then
        waydroid_down
        sleep 0.3
        rm_magisk
        sleep 0.3
        resize_images
        sleep 0.3
        install_magisk
        waydroid_up
        sleep 0.5
        echo "Installation has finished, now start up waydroid and after waydroid fully boots and If magisk was successfully installed then just simply reboot your Waydroid or proceed direct install to system through Magisk app. Enjoy Magisk <3"
        rm -rf init.txt
    elif [ $a = "3" ]; then
        echo "Aborting!"
    fi
}

prep
sleep 0.3
promt
sleep 0.3
install
