#!/bin/bash

# sed -i -e 's/\r$//' sharedFolderWithHost.sh

function printGreen {
	echo -e "\e[92m${1}"
}

printGreen "Create/use this folder when mounting (Absolute Path)"
read pathForMounting
mkdir -p $pathForMounting

printGreen "Type the name of the host folder"
read hostFolder

sudo mkdir /media/cdrom
sudo mount -t iso9660 /dev/cdrom /media/cdrom
sudo apt-get update
sudo apt-get install -y build-essential linux-headers-`uname -r`
sudo /media/cdrom/./VBoxLinuxAdditions.run

echo "$hostFolder	$pathForMounting	vboxsf	defaults	0	0" | sudo tee -a /etc/fstab
echo "vboxsf" | sudo tee -a /etc/modules
sudo reboot now