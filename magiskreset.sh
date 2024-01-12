#!/bin/bash
loope=true
a=""
clear
function promt() {
    while [ $loope = true ]; do
        echo "Do you want to uninstall Magisk Delta from waydroid? (1)"
        echo "Do you want restore Magisk to its original state and remove all modules? (2)"
        echo "Abort (3)"
        read -p "Make a choice (choose number):" a
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
        echo "Selected option: $a"
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

function reset_magisk() {
    if [ $a = "1" ]; then
        echo "Removing Magisk!"
        sudo rm -rf ~/.local/share/waydroid/data/adb/lspd
        sudo rm -rf ~/.local/share/waydroid/data/adb/magisk
        sudo rm -rf ~/.local/share/waydroid/data/adb/magisk.db
        sudo rm -rf ~/.local/share/waydroid/data/adb/modules
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
    elif [ $a = "2" ]; then
        echo "Reseting Magisk and removing all modules!"
        sudo rm -rf ~/.local/share/waydroid/data/adb/lspd
        sudo rm -rf ~/.local/share/waydroid/data/adb/magisk.db
        sudo rm -rf ~/.local/share/waydroid/data/adb/modules
        sudo rm -rf ~/.local/share/waydroid/data/adb/post-fs-data.d
        sudo rm -rf ~/.local/share/waydroid/data/adb/service.d
    fi
}

function waydroid_up() {
    echo "Starting waydroid!"
    if grep -Fxq "runit" init.txt; then
        sudo sv up waydroid-container
    else
        sudo systemctl start waydroid-container.service
    fi
}

function reset() {
    if [[ $a = "1" || $a = "2" ]]; then
        waydroid_down
        sleep 0.3
        reset_magisk
        sleep 0.3
        waydroid_up
        if [ $a = "1" ]; then
            echo "Magisk removed, goodbye!"
        elif [ $a = "2" ]; then
            echo "Magisk restored!"
        fi
        rm -rf init.txt
    else
        echo "Aborting!"
    fi
}

promt
sleep 0.3
reset
