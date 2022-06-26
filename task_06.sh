#!/bin/bash
SUDO_UID=0     
E_NOTSUDO=100  

read -rp "Install or Upgrade NGINN? (y/n) " INSTALL

if [[ $INSTALL =~ ^([yY][eE][sS]|[yY])$ ]]; then

    if [ "$UID" -ne "$SUDO_UID" ]
    then
        echo "Must be root to run this script."
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
source task_02.sh
which curl &> /dev/null || apt install curl -y && {
 rm -r -f /var/www/html/*

 STUDENT_NAME="Eesha Qureshi"
 STATUS=$(systemctl status nginx | grep Active | awk '{print $2}')
 AWSCLI_VERSION=$(aws --version | awk '{print $1}' | tr '/' '-')
 NGINX_VERSION=$(nginx -v 2>&1 | awk -F' ' '{print $3}' | cut -d / -f 2)
 EC2_INSTANCE_COUNT=$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].InstanceId" --output text | wc -l)
 SG_COUNT=$(aws ec2 describe-security-groups --query "SecurityGroups[*].{Name:GroupName,ID:GroupId}" --output text | wc -l)

 sed -i "s/STUDENTNAME/$STUDENT_NAME/g" index.html
 sed -i "s/NGINXSTATUS/$STATUS/g" index.html
 sed -i "s/VERSIONAWS/$AWSCLI_VERSION/g" index.html
 sed -i "s/NGINXVERSION/$NGINX_VERSION/g" index.html
 sed -i "s/EC2COUNT/$EC2_INSTANCE_COUNT/g" index.html
 sed -i "s/SECGRPCOUNT/$SG_COUNT/" index.html

 mv index.html /var/www/html/
}
