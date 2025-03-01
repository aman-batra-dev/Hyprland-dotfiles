# Your friendly guide to Arch Linux Installation

## Introduction
Disclaimer: Installing an OS most likely causes data loss on your system. It is highly recommended to backup your data into an external storage device.

Objective of this guide is make Arch as most beginer friendly as it can be providing an easier learning experience to its readers.

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
iwtcl
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
this will list all the available disks.

Your screen may look like this:

![image](https://github.com/user-attachments/assets/72212654-ce1d-4305-9670-8b4e1c47c045)

The partition naming in linux is as follows: ```/dev/<name-of-disk>```
This "name of disk" can be ```sd<the order in which they are found>```, ```sd``` in general used to refer to as a storage device, ```sda``` means this device was found first. Similarly ```sdb``` means this device was found second and so on. The order follows the alphabetic order. 
OR
the "name of disk" can be ```nvme0n1```,```nvme0n2```,```nvme0n3``` and so on. 

This totally depends on your system. How it identifies your storage device. Usually ```nvme0n1``` are SSD devices and ```SDA``` are HDD devices. To make sure you are using your correct storage device, your can compare the size of the storage devices with data you collected in the prerequisits step.
