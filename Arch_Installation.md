# Your friendly guide to Arch Linux Installation

## Introduction
Disclaimer: Installing an OS will most likely cause data loss on your system. It is highly recommended to backup your data into an external storage device.

Objective of this guide is to make Arch as most beginer friendly as it can be, providing an easier learning experience to its readers.

#### Why do you want to install Arch?
If you are a total beginner to Linux in general, you might be facing a dilemma, that Should you switch to Arch? Will it break your system to no return? Or You might be intimidated by the complexity of a Linux OS in general. 
If you are too unsure or don't want to learn something new, I will highly recommend to stick to your current OS and forget about switching. But if you are eager to learn, and want full control over your system then this guide can help you a lot.

Some advantages of using Arch over any other OS (My opinion):
1. Your system is totally under your control. You will be building your OS like some lego blocks. You keep whatever you like and remove what you don't want. No bloats, no over utilized resources, no restrictions.
2. You may break a few things in your journey, all of which are going to be software related and totally reversible.
3. Personally I got a massive performance upgrade on Arch compared to any other OS, reason being I installed very specific packages to boost my overall game development and programming performance. Practically, this topic is subject to use case.
4. Usually people think their hardware is not good enough for some tasks but in reality performance comes down to how these hardware components are managed by the OS. In this area Arch's kernel shines a lot. On the brighter side you can customize your Arch to do certain hardware optimizations.

Disadvantages:
1. Just like in real life, freedom in OS customization requires you to learn those things, understand their downsides and take your steps wisely.
2. Once you get comfortable with Arch, you won't be hopping to any other distro or OS.
## Prerequisits
These are just steps taken to make sure you don't end up messing up the installation. Go to your disk manager, and note down all the partitons and their size.

## Creating a bootable USB
Before diving into installation, we have to create an installation medium. By installation medium I mean an external device using which we will install Arch on our system's drive. We will achieve this using a USB pendrive.  

**Caution**: Your USB pendrive will be formated in this procedure. Make sure to backup your data.

1. Download the official arch iso from [here](https://archlinux.org/download/).
2. Download ventoy from [here](https://www.ventoy.net/en/download.html)
3. Open Ventoy and select your USB device.
4. Press Install.
5. A partition will appear under the name "Ventoy".
6. Now copy arch iso file into this partition.
7. Reboot your system and open the boot menu. Boot menu key depends on your computer's model. Unfortunately you may have to google it.
8. Boot into your USB pendrive.
9. Select Arch Iso to begin the installation process.

## Installation for the base linux
This section will cover up installing the necessary packages that are required to run your Arch. Keep in mind this section will not cover any gui or beutification aspect as those will be covered in further sections. The reason for the division of these sections is to give user a clear picture of each and every component they are going to install. 

Your screen may now look like this:

![image](https://github.com/user-attachments/assets/7ca72ee0-fbe4-456e-b3f8-fc0b99b2edd3)

Currently we have loaded an instance of Arch from our USB. This instance is an OS in itself. We will be using this OS installed on our USB pendrives to install the Arch on our system's storage device. 

### Connecting to Wifi
We will use a utility known as iwctl to connect to out wifi network. Internet access is very crucial during the installation process. If you are connected to the ethernet, you can skip this step entirely.

Type the following commands in your terminal.
``` bash
iwctl
```
- This will open "iwd".
- Now we have to find our network adapter name
``` bash
device list
```
- We have to tell the system to scan for avialable networks using the specified wifi adapter. Note: anthing that is in < > these brackets is a variable and is to filled according to your device specification. 
``` bash
station <name-of-the-wifi-adapter> scan
```
- Now to display the list of available networks.
``` bash
station <name-of-the-wifi-adapter> get-networks
```
- To connect to a network we will do the following:
``` bash
station <name-of-the-wifi-adapter> connect <name-of-your-wifi-network>
``` 
- You will asked to enter your wifi password, once done a little arrow will appear along with the name of your wifi network.
- Press ``` Ctrl+D``` to exit from the wifi utility. This will not disconnect you from your wifi.

### Setting the time
```bash
timedatectl set-ntp true
```
- In general any command that has 'ctl' at its end is a service.
- In the above case timedatectl is a service to manage time and date on your machine. The option "ntp" refers to Network Time Protocol. It is there to auto update your system's time through internet.

### Updating the mirrorlist
Mirror list are the urls or in layman "internet links" from which Arch's package manager "pacman" downloads all the packages. Unlike Windows, Arch users don't have to go to specific sites to download. With one command pacman searches all the official databases to download the desired software. We will discuss more about pacman and its usage in later sections.

Lets update the mirror list to select the fastest URL available for your region.
```bash
sudo reflector --age 6 --latest 200 --fastest 20 --threads 20 --sort rate --protocol https --verbose --save /etc/pacman.d/mirrorlist
```

By default pacman allow downloading only one package at a time, we can introduce parallel downloading which will significatly reduce the downloading time.
```bash
nano /etc/pacman.conf
```
- This will open the GNU Nano text editor. Scroll down to line ```#ParallelDownloads = 5``` and remove the # from it. Resulting will look like this ```ParallelDownloads = 5```. # before any statement means we have commented that statement, in simpler terms that statement will only be identified as user message, not a runnable command. To save the changes press ```Ctrl + S```, and to exit the Nano ```Ctrl + X```.

### Disk Partitioning
This is the most crucial step and requires your utmost attention.
We will be creating isolated sections on your system storage device, the goal of these isolated sections is to isolate some crucial system files from one another.

Lets Begin:

First we have to identify how many disks we have, how many partitions each disk have and on which disk we desire to install our Arch Linux.
``` bash
fdisk -l
```
this will list all the available disks. Here we used ```fdisk```, which is a disk management utility. The ```-l``` means we are requesting ```fdisk``` to list all the available storage devices.

Your screen may look like this:

![image](https://github.com/user-attachments/assets/72212654-ce1d-4305-9670-8b4e1c47c045)

The partition naming in linux is as follows: ```/dev/<name-of-disk>```.   
This "name of disk" can be ```sd<the order in which they are found>```, ```sd``` in general used to refer to as a storage device, ```sda``` means this device was found first. Similarly ```sdb``` means this device was found second and so on. The order follows the alphabetic order.    
OR   
the "name of disk" can be ```nvme0n1```,```nvme0n2```,```nvme0n3``` and so on.    

This totally depends on your system. How it identifies your storage device. Usually ```nvme0n1``` are SSD devices and ```SDA``` are HDD devices. To make sure you are using your correct storage device, your can compare the size of the storage devices with data you collected in the prerequisits step.   

Now select the desired storage device with the following commnand:
```bash
fdisk /dev/<name-of-your-disk>
```
- This will open the fdisk utility to perform operations only on the selected storage device.

Entering ```p``` will list all the available partitions on the selected disk.   
Entering ```n``` will create a new partition on the selected disk.   
Entering ```t``` will change the type of the selected partition.   
Entering ```d``` will delete the selected partition.
Entering ```w``` will write the changes.  

We will be needing mainly 3 partitons apart from that you can create as many partitions as you want.

The main 3 partitions should look like this:

![image](https://github.com/user-attachments/assets/8166d115-6483-4093-8654-f54944b6661d)

We want: 
- 1st partition to always be of type ```EFI System```, recommended size of this partition is ```550 MB```. This partition will be storing all the applications which will be executed as soon as you turn on your pc. Notice when you use a Windows pc, you get a loading icon with windows logo before the windows itself is loaded. The application I am talking about is referred to as a bootloader. The function of a bootloader is to locate where the OS is installed and load it. We will be using Linux bootloader known as ```grub```. Boot loader executes as soon as the pc starts and is stored in this EFI partition. This partiton is also referred as the boot partition. 

- 2nd partition to always be of type ```Linux Swap```, recommended size of this partition is ```<your size of total RAM> x 2```. In any operating system, RAM management is a must. There can be times when RAM can be completely filled, during such situations a system crash can happen. Luckily each OS has its own way to counter this situation. Windows have paging system and Linux has swap system. Basically Linux automatically moves those processes running in the background which do not require your immediate attention from RAM to swap partition, resulting free space in RAM. 

- 3rd partition to always be of type ```Linux Filesystem```, minimum recommended size ```100GB```. This will be our final partition which will contain our OS. Each and every OS and user files will be stored in this partition. This partition can be of any size you want. Total size for Arch depends on what components you are installing. You can install the most ligthweight components or most heavy components depending on your needs. On average Arch takes max upto 7-8 GB of storage. This parition is also referred as the ```Root Partition```.

To create these partitions:   
- List all the available partitions.
- Delete all the existing partitions one by one.
- Create 3 new partitions using ```n```. For each partiton, you will be asked what should be its parition type: set the parition type as primary, first sector: keep first sector of each partition to be default, and for the last sector enter the size as follows: ```+<Amount><Units>```. For example, to create a partition of 8 GB, you will leave the first sector as it is, and in last sector you will enter ```+8G```. Arch will auto-calculate the last sector depending on the size entered. Similarly for a 550 MB partiton, last sector will be ```+550M```. If ```fdisk``` asks to format a signature just press ```y```. We want are partitions to be totally blank.
   
- Now list all the partitions, to check if all the necessary partitions are made or not. You will notice each of them is now having the type as ```Linux Filesystem```, which doesn't match with our required types. We are going to fix these types now.
- Press ```t``` to change the partition type. Select the partition number you want to change the type for. And then you will be asked for the type ID. 
Partition ID chart:
- ```EFI System -> 1```
- ```Linux Swap -> 19```            
   
For example we want first partition to be an EFI System, so we will input ```t``` and it will ask us the partition number. We will input ```1``` to select the first partiton. Then it will ask the type for that partition, we will input '''1''' to select ```EFI System``` as our option. Similarly for Swap Partition, ```Partition Number: 2``` and ```Type ID: 19```.

- Press ```w``` to save changes and exit.

Now we have to create filesystems for these partitions.   

You might be confused by now. We just created three partitions, each of some specific use. Why do we have to create a filesystem now? Haven't we already specified the types of partitions?

These technical terms may sound overwhelming, but in reality they are very simple. The partitions stores the data in them, the type of the partition specifies what type of data will this partition will store and the filesystem specifies how this data will be stored in its respective partition. Filesystems can be of various types. Windows supports ```NTFS```, ```FAT```, ```FAT32``` and ```extFAT``` format, whereas Linux systems works with ```ext4```, ```btrfs```, ```NTFS```, ```FAT 32``` and many more. 

We will be using these filesystems for our partitions:
- EFI Partition: ```FAT32```
- Swap Partition: ```Swap```
- Root Parition: ```BTRFS```

The procedure will be as follows:
- For EFI Partition:
     ```bash
     mkfs.fat -F 32 /dev/<name-of-the-boot-partition>
     ```
- For Swap Partition:
     ```bash
     mkswap /dev/<name-of-the-swap-partition>
     swapon /dev/<name-of-the-swap-partition>
     ```
- For Root Partition:
     ```bash
     mkfs.btrfs /dev/<name-of-the-root-partition>
     ```
We are done with creating our paritions and their filesystems. Now we have to load these partitions so that we can begin installing our packages into them.   
Before that we must understand a little more about storage systems. Partitions are by default not accessible until they are loaded by the OS. This loading of a partition is called mounting.   
Lets take an example: I created a drive to store all my games in my Windows system. By default Windows mount any drive as soon as one is detected. So I don't have to mount this partition by myself. Does this make Linux's manual mounting irrelevant? the answer is no. Linux allows their users to mount a parition manually or automatically. Its all about how you want your system to behave.

Mounting Partitions:
- ```bash
  mount /dev/<root-parition> /mnt
  ```
  
  - As we know every command we ran till yet, was executed in the instance of Arch installed on the USB Pendrive. Hence we mount our root partition to ```mnt``` directory in our USB pendrive. What it means is if we want to access files inside the root partition we can simply access them by just opening the ```mnt``` folder.
  
-  ```bash
   btrfs su cr /mnt/@
   btrfs su cr /mnt/@home 
   btrfs su cr /mnt/@var
   btrfs su cr /mnt/@opt
   btrfs su cr /mnt/@tmp
   umount /mnt
   ```
   - Now we are creating subvolumes in our root partition. The goal of these subvolumes is to isolate each of the sections of our OS. ```Home``` is where user files are installed, this is much similar to ```ThisPC``` in Windows. ```Var``` is used to store log files. ```Opt``` is used to store optional third party apps. ```Tmp``` is used to store temporary files.


Mounting the subvolumes:

- ```bash
  mount -o noatime,commit=120,compress=zstd,subvol=@ /dev/<root-partition> /mnt
  mkdir /mnt/{boot,home,var,opt,tmp}
  mount -o noatime,commit=120,compress=zstd,subvol=@home /dev/<root-partition> /mnt/home
  mount -o noatime,commit=120,compress=zstd,subvol=@opt /dev/<root-partition> /mnt/opt
  mount -o noatime,commit=120,compress=zstd,subvol=@tmp /dev/<root-partition> /mnt/tmp 
  mount -o subvol=@var /dev/<root-partition> /mnt/var
  ```

Mounting the boot partition:
- ```bash
  mount /dev/nvme0n1p1 /mnt/boot
  ```

## Installing the base system
We are finally done with any heavy tasks, now it time to install basic Arch on the partitions we created and mounted.

```bash
pacstrap /mnt base linux linux-firmware nano btrfs-progs
```
- ```pacstrap``` is the installer we are using
- ```mnt``` is the location where we want to install our packages
- rest are the packages we want to install
- Details of each package:
  - ```Base```: This installs the essential system utilities required for Arch Linux to function.
  - ```linux```: This installs the kernel, kernel is the main bridge between software and hardware components. It is one of the most important component. If you want to do gaming on Arch use ```linux-zen``` instead of ```linux```.
  - ```linux-firmware```: Basic software for hardware components, such as wifi card, bluetooth, etc
  - ```nano```: This is a text editor, we will be using to edit some text files.
  - ```btrf-progs```: This installs utilities for managing the Btrfs filesystem.

Note: If your are using AMD processor your have to additionally install ```amd-ucode```. 

## Generating the fstab
Fstab is the file which will automatically do the mounting for you as soon as the system boots. So you don't have to do anything manually.

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

## Temporary accessing the System OS through USB Os.

```bash
arch-chroot /mnt
```
- Now we are in our OS installed in our system's storage device. Every command we run now will affect our system's OS not the USB OS.

### Setting the time and date

```bash
timedatectl set-timezeone <your timezone>

hwclock --systohc
```

### Setting up the locale

```bash
nano /etc/locale.gen
```
- Uncomment the line: ```en_IN.UTF-8``` or something similar depending upon your region.
```bash
locale-gen
```
```bash
echo LANG=en_US.UTF-8 >> /etc/locale.conf
```

### Network configuration

```bash
echo <hostname> >> /etc/hostname 
```
- Example: ```echo ArchLinux >> /etc/hostname```
- Your <hostname> can be anything you like.

```bash
nano /etc/hosts
```
- This will open the nanno editor. Add the following into the opened file.
  - ```bash
    127.0.0.1	localhost
    ::1		localhost
    127.0.1.1	<hostname>.localdomain <hostname>
    ```
### Setting the root password

```bash
passwd
```

### Editing the pacman config to enable parallel downloads
We earlier did this step but that was for the pacman stored on our USB instance of Arch. Now we will be doing it for our System OS.
Edit the /etc/pacman.conf and uncomment the ParallelDownloads line.

### Installing packages

```bash
pacman -S grub grub-btrfs efibootmgr base-devel linux-headers networkmanager network-manager-applet wpa_supplicant os-prober mtools dosfstools git reflector bluez bluez-utils xdg-utils xdg-user-dirs --needed
```

### Generating Initramfs file
As we have previously discussed how your operating system loads as soon as you power on your pc. We discussed first the bootloader is loaded, then the bootloader loacates and loads the OS.
But in between your bootloader and your Linux OS there is one more file which is loaded, it is the initramfs. Initramfs to understand laymanly is a small temporary root filesystem loaded into memory at boot before switching to the real root filesystem. Your OS stored in this real root filesystem. Revising the workflow:   

```pc starts-> Bootloader is loaded -> BootFSoader loades initramfs -> initramfs loades root filesystem -> OS is loaded```.

To generate this initramfs:
```bash
nano /etc/mkinitcpio.conf
```
- this will open the config file for mkinitcpio which will be used to generate the initramfs file
- Find the ```MODULES``` block and add ```btrfs``` to it. This will look like this:  ```MODULES=(btrfs)```.
- Save and exit

```bash
mkinitcpio -p linux
```
- This will generate the initramfs file

### Installing the bootloader

```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
```
- This file will install bootloader. Name of our bootloader is ```grub```.

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```
- This will create a config file for grub.

### Configuring the user account

```bash
useradd -mG wheel,audio,video,storage,power <name of the user>
```
- This will create a user with specified permissions
- Now we want to assign a password to this user

```bash
passwd <name of the user>
```
- To make sure our user can run sudo commands we uncomment this line ```%wheel ALL=(ALL) ALL``` in
```bash
nano /etc/sudoers
```
- Sudo is basically your "run as admin" to any command.











