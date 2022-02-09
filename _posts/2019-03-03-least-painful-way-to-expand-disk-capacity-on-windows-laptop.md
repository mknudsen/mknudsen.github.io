---
layout: post
title:  "expanding or swapping out disk on a windows laptop"
date:   2019-03-03 11:39:00 +0100
categories: hints
tags: windows clonde disk harddisk hdd ssd
---

Here I'll shortly introduce the least painful way to expand disk capacity (by swapping out the main harddisk) on a windows laptop.

You will need an external hard disk docking station capable of cloning. I used a [model from Raidsonic](https://www.raidsonic.de/products/external_cases/hdd_ssd_docking/index_de.php?we_objectID=1700).

On the software side you need either an USB thumb drive or a CD/DVD with a [GParted](https://gparted.org/) live system. The ISO can be copied to a bootable USB drive with [UNetbootin](https://unetbootin.github.io/).

- remove the old drive from the laptop
- clone the drive (mind the cloning direction of the dock!)
- install the new drive into the laptop
- start windows to verify that the cloning worked
- reboot the laptop and start the GParted live system
- expand size of the primary partition and apply the changes
- restart windows

Windows will start by checking the partition for errors. This is normal and should finish without errors.

You now should be able to use the new space in windows. If something goes wrong you still have the old drive as backup.