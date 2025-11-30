#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
	echo "Please try with sudo user "
fi

if [[ "${#}" -lt 1 ]]
then
	echo "Usage: ${0} Username Comment.."
fi

USER_NAME=${1}
echo "USER_NAME = $USER_NAME"

#In case of more than one argument, store it as account comments

shift
COMMENT="${@}"

#Create a password

PASSWORD=$(date +%s%N)

#create the user
useradd -c "${COMMENT}" -m $USER_NAME
 
#check if the user is successfully created or not
if [[ $? -ne 0 ]]
then
	echo "The account could not be created.."
	exit 1
fi

#set the password for the user

echo $PASSWORD | passwd --stdin $USER_NAME

#Check if the password successfully set or not

if [[ $? -ne 0 ]]
then
	echo "Password could not be set "
	exit
fi

#Force password change of first login

passwd -e $USER_NAME

#Display the username, password andd the host wher the user was created
echo
echo "Username: $USER_NAME"
echo
echo "Password: $PASSWORD"
echo
echo $(hostname)

