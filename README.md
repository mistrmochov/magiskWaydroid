# magiskWaydroid
__________________________________________________________________________________________________________________________________________________________________________________________
Changelog:

(V - 0.8): Added arm64 support, but I don't have any arm device, So I was not able to test It. So If you anyone will be using arm version, please let me know, If it works :)

(V - 0.8.4): Added option to install Magisk together with lsposed and magisk builtinbusybox modules. And also in magiskremove script, added feature to restore Magisk to its original state and remove all modules.

(V - 1.0): The script has been simplified and improved, the options are now being chosen by arguments, the script is only one file. LSPosed module updated.

(V - 1.1): Finally tested on aarch64 device, added option to install Magisk with modules!
__________________________________________________________________________________________________________________________________________________________________________________________

Small script, that just places preinstalled magisk to your Waydroid. Fully working Magisk Delta!!
Please kindly read everything here and follow insctructions, or It might not work properly!

**The script has now been changed and works little differently, So please follow the instructions below!**

![installedmagisk](https://storage.googleapis.com/mistrmochov-x/magiskWaydroid/installedmagisk.png)

**Purpose of this script.**

 Use this script if the script from nitanmarcel doesn't work. This script copies "preinstalled" magisk to your Waydroid. These files are generated from the script, that I mentioned before and I made script based on this so others can benefit. 
 Note: With this script you get only one version of Magisk, which is Magisk Delta 26.3 (Not Kitsune Mask). Magisk Delta fully works and you can install all the sweet stuff and modules you want.

 Please, If you have an idea, how to make scripts better and accessible to more people, feel free to pull requests, I will be happy to make the script better.

 **Requirements**

 waydroid,
 git,
 tar,
 gzip,
 wget

 **Install instructions**
 
 First please make sure, that your Waydroid is installed and initialized!
 If you have fresh waydroid install and your Waydroid has never started, please start up the waydroid. (data folder has to exist!)

 If you have been installing magisk from nitanmarcel script, make sure you run: "sudo waydroid_magisk remove", before installing this script! Althought, now this script should remove all conflicting files.
 ```shell
git clone https://github.com/mistrmochov/magiskWaydroid
cd magiskWaydroid
```
 ```shell
./magisk install # This option will install Magisk
```
 ```shell
./magisk install --modules # This option will install Magisk with mentioned modules.
```
 ```shell
./magisk remove # This option will completely remove Magisk from your Waydroid
```
 ```shell
./magisk reset # This option will restore Magisk to its original state and remove all modules.
```
If you intend to use the script in the future, I recommend to place the script in /usr/bin or ~/.local/bin, You can then run it directly in your shell from anywhere. Make sure It has executable permissions.


 IMPORTANT: After script installation start up the Waydroid and after It boots up, check If Magisk was installed, If yes then please restart your Waydroid to complete the installation proccess or you can also proceed with direct install to system through Magisk app.
 
 With magisk installed, Waydroid usually boots longer and in first boot after you install magisk, It can take few seconds untill Magisk manager pops up, So if it's not in the applications, just wait.
 Also please do not update Magisk to Kitsune Mask or you will lose root.
 
 **Compatibility**
 
 Now this script supports x86_64 and arm64 archs.
 
 If you're using Archlinux based distros appearently, you don't need linux-xanmod-anbox kernel anymore. You can go with linux-zen and It's header, which is official from Arch repos. Magisk is now working fine with this kernel :)

