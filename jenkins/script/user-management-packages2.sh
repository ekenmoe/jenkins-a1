#!/bin/bash


# ubuntu = Ubuntu
# redhat = Red Hat Enterprise Linux
# centos = CentOS Linux
# amazon-ec2 = Amazon Linux

PACKAGES=$1
USERNAME=$2
PASSWORD=$3
EMAIL=$4
FIRSTNAME=$5
LASTNAME=$6

OS_NAME=$(cat /etc/*release |grep -w NAME |awk -F'"' '{print$2}')

function ubuntu {
    echo "This is $OS_NAME OS."
    sleep 5
    apt update -y
    apt install -y $PACKAGES
}

function centos_redhat_ec2 {
    echo "This is $OS_NAME OS."
    sleep 5
    yum update -y
}

if [ "$OS_NAME" == "Ubuntu" ]; then
    ubuntu
elif [ "$OS_NAME" == "Red Hat Enterprise Linux" ] || [ "$OS_NAME" == "CentOS Linux" ] || [ "$OS_NAME" == "Amazon Linux" ]; then
     centos_redhat_ec2
else
    echo "HUMMMM. I don't know this OS."
fi


echo "Username: ${USERNAME}"
echo "Password : ${PASSWORD}"
echo "Email: ${EMAIL}"
echo "First Name: ${FIRSTNAME}"
echo "Last Name: ${LASTNAME}"
echo "Account management: ${ACCOUNT_MANAGEMENT}

manage_user_account() {
    if [ "$1" == "add_user" ]; then
        if ! grep -q "^$2:" /etc/passwd; then
            sudo useradd -m "$2"
            echo "$2:$3" | sudo chpasswd
            sudo usermod -c "$4 $5" "$2"
            sudo cat /etc/passwd | grep "$2"
            sudo cat /etc/shadow | grep "$2"
            ls /home
        else
            echo "User $2 already exists"
        fi
    elif [ "$1" == "delete_user" ]; then
        if ! grep -q "^$2:" /etc/passwd; then
            echo "User $2 does not exist"
        else
            sudo userdel -r "$2"
            echo "The user $2 with password $3 has been deleted"
            sudo cat /etc/passwd | grep "$2" || true
            sudo cat /etc/shadow | grep "$2" || true
        fi
    elif [ "$1" == "lock_user" ]; then
        if ! grep -q "^$2:" /etc/passwd; then
            echo "User $2 does not exist"
        else
            sudo passwd -l "$2"
            echo "The user $2 with password $3 has been locked"
            sudo cat /etc/shadow | grep "$2"
        fi
    elif [ "$1" == "unlock_user" ]; then
        if ! grep -q "^$2:" /etc/passwd; then
            echo "User $2 does not exist"
        else
            sudo passwd -u "$2"
            echo "The user $2 with password $3 has been unlocked"
            sudo cat /etc/shadow | grep "$2"
        fi
    else
        echo "Invalid ACCOUNT_MANAGEMENT action: $1"
    fi
}