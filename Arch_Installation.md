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

We will be needing mainly 3 partitons apart from that you can create as many partitions as you want.

The main 3 partitions should look like this:

![image](https://github.com/user-attachments/assets/8166d115-6483-4093-8654-f54944b6661d)

We want: 
- 1st partition to always be of type ```EFI System```, recommended size of this partition is ```550 MB```. This partition will be storing all the applications which will be executed as soon as you turn on your pc. Notice when you use a Windows pc, you get a loading icon with windows logo before the windows itself is loaded. The application I am talking about is referred to as a bootloader. The function of a bootloader is to locate where the OS is installed and load it. We will be using Linux bootloader known as ```grub```. Boot loader executes as soon as the pc starts and is stored in this EFI partition. This partiton is also referred as the boot partition. 

- 2nd partition to always be of type ```Linux Swap```, recommended size of this partition is ```<your size of total RAM> x 2```. In any operating system, RAM management is a must. There can be times when RAM can be completely filled, during such situations a system crash can happen. Luckily each OS has its own way to counter this situation. Windows have paging system and Linux has swap system. Basically Linux automatically moves those processes running in the background which do not require your immediate attention from RAM to swap partition, resulting free space in RAM. 

- 3rd partition to always be of type ```Linux Filesystem```, minimum recommended size ```100GB```. This will be our final partition which will contain our OS. Each and every OS and user files will be stored in this partition. This partition can be of any size you want. Total size for Arch depends on what components you are installing. You can install the most ligthweight components or most heavy components depending on your needs. On average Arch takes max upto 7-8 GB of storage.

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
