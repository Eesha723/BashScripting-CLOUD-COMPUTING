#!/bin/bash

SUDO_UID=0
E_NOTSUDO=100

read -rp "Install or Upgrade NGINN? (y/n) " INSTALL

if [[ $INSTALL =~ ^([yY][eE][sS]|[yY])$ ]]; then

    if [ "$UID" -ne "$SUDO_UID" ]
    then
        echo "Must be sudo user to run this script."
        exit $E_NOTSUDO
    fi  

	which nginx &> /dev/null || {
		echo "Installing nginx"
		apt install update -y 
		apt install upgrade -y
		apt install nginx 
        echo;
        echo "Installed NGINX !"

	} && {
		echo "Updating nginx"
		apt install update -y 
		apt install upgrade -y
		apt install nginx --upgrade
	}

	echo "Completed."
fi
