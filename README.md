# magiskWaydroid

Changelog (V - 0.7): Added support for runit init system, but on voidlinux magisk doesn't work, because of some incompatibility with magisk busybox, I'm working on some solution!

Changelog (V - 0.8): Added arm64 support, but I don't have any arm device, So I was not able to test It. So If you anyone will be using arm version, please let me know, If it works :)

Small and quick script, that puts finished magisk files to waydroid directory. Fully working Magisk Delta!!
Please kindly read everything here and follow insctructions, or It might not work properly!

![installedmagisk](https://magiskwaydroid.fra1.digitaloceanspaces.com/magiskimage.png)

**Purpose of this script.**

 Use this script if the script from nitanmarcel doesn't work. This script copies "preinstalled" magisk to your waydroid directory. These files are generated from the script, that I mentioned before and I made script based on this so others can benefit. 
 Note: With this script you get only one version of Magisk, which is Magisk Delta 26.3 (Not Kitsune Mask). Magisk Delta fully works and you can install all the sweet stuff and modules you want.

 Please keep in mind, that this script will propably not work on all system configuration. For example, these files are only for x86_64 architecture, for which these files were generated! But I will try my best to make the script full complete, It 
 was meant as temporary solution for replacing other scripts.

 Also please, If you have an idea, how to make scripts better and accessible to more people, feel free to pull requests, I will be happy to make the script better.

 **Requirements**

 waydroid
 git
 tar
 gzip

 **Install instructions**
 
 First please make sure, that your Waydroid is installed and initialized!
 If you have fresh waydroid install and your Waydroid has never started, please start up the waydroid. (data folder has to exist!)

 If you have been installing magisk from nitanmarcel script, make sure you run: "sudo waydroid_magisk remove", before installing this script! Althought, now this script should remove all conflicting files.
 ```shell
git clone https://github.com/mistrmochov/magiskWaydroid
chmod +x magiskinstall.sh
./magiskinstall.sh (DO NOT RUN AS ROOT OR SUDO, or it wont work, but when you are prompted for sudo password put it there of course!)
```
 then press y

 IMPORTANT: After script installation start up the Waydroid and after It boots up, check If Magisk was installed, If yes then please restart your Waydroid to complete the installation proccess or you can also proceed with direct install to system through Magisk app.
 
 For removal use magiskremove.sh
 
 With magisk installed, Waydroid usually boots longer and in first boot after you install magisk, It can take few seconds untill Magisk manager pops up, So if it's not in the applications, just wait.
 Also please do not update Magisk to Kitsune Mask or you will lose root.
 
 **Compatibility**
 
 These files are for x86_64 architecture, so If you have any other architecture my script will simply stop itself.
 
 If you're using Archlinux based distros you need linux-xanmod-anbox kernel and its header!

