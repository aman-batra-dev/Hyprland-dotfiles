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

#### Creating a bootable USB
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

#### Installation for the base linux
This section will cover up installing the necessary packages that are required to run your Arch. Keep in mind this section will not cover any gui or beutification aspect as those will be covered in further sections. The reason for the division of these sections is to give user a clear picture of each and every component they are going to install. 
