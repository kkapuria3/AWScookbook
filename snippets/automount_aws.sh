#!/bin/bash

## Karan Kapuria 

#### -------------------  MOUNT STORAGE  -----------------
#### -----------------------------------------------------

nohup lsblk > avail_disk.log
storage_name=$(tail -n 1 avail_disk.log | awk '{print $1}')
sudo mkfs -t ext4 /dev/$storage_name
sudo mkdir /volumes  										
sudo mount /dev/$storage_name /volumes

