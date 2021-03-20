#!/bin/bash

################################
# Utils functions
################################

function checkStatusAndExitWithMessage {
	if [ $1 -ne 0 ]
	then 
		echo -e "\e[31m${2}"
		exit $3
	fi
}

function printRed {
	echo -e "\e[31m${1}"
}

function printGreen {
	echo -e "\e[92m${1}"
}

function printYellow {
	echo -e "\e[93m${1}"
}

function printBlue {
	echo -e "\e[1;34m${1}"
}

#################################################################
# START of the script
#################################################################

if [ `id -u` -eq 0 ]; then
	printRed "Please do not run this script as root. The script will use the sudo where necessary"
	exit 1
fi

printGreen "Installing some dependencies"
sudo apt update
sudo apt install curl
checkStatusAndExitWithMessage $? "err 6" $?

printGreen "Adding docker repo"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
checkStatusAndExitWithMessage $? "err 7" $?

printGreen "Install docker"
sudo apt-get install -y docker-ce
checkStatusAndExitWithMessage $? "err 14" $?
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
checkStatusAndExitWithMessage $? "err 15" $?
sudo chmod +x /usr/local/bin/docker-compose
checkStatusAndExitWithMessage $? "err 16" $?
sudo usermod -aG docker $USER
checkStatusAndExitWithMessage $? "err 17" $?


printGreen "End of the script"
printYellow "Please reboot the system"
exit 0
