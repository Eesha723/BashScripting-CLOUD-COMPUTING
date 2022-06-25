#!/bin/bash

SUDO_UID=0     # Only users with $UID 0 have root privileges.
E_NOTSUDO=100  # Non-root exit error.
error=200

if [ "$UID" -ne "$SUDO_UID" ]
then
  echo "Must be sudo user to run this script."
  exit $E_NOTSUDO
fi  
which nginx &> /dev/null || {
 echo -e "\e[31mSomething went wrong, NGINX cannot be activated\e[0m"
 exit $error
} && {
nginx_status=$(systemctl status nginx | grep Active)
if [[ $nginx_status = "inactive" ]]
then 
	echo -e "\e[31mNGINX is Dead. Do you want to run NGINX [y/n]?\e[0m"
read input 

if [[ $input = "y" ]]
then 
	systemctl start nginx
else 
	echo -e "\e[31mSomething went wrong, NGINX cannot be activated\e[0m"
fi
else
	echo -e "\e[32mNGINX is Running Successfully\e[0m"
fi
}

