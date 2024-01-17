#!/bin/bash

#script should be execute with root or sudo privilage
if [[ "${UID}" -ne 0 ]]
then
  echo "please run with sudo or root"
  exit 1
fi

#user should provide atlease one argument with username else guide him
if [[ "${#}" -lt 1 ]]
then
  echo "usage: ${0} USER_NAME [COMMENT].."
  echo 'create a user with name USER_NAME and comment field of COMMENT'
  exit 1
fi

#Store first argument as username
USER_NAME="${1}"


#if there is more then one comment
shift
COMMENT="${@}"


#create a password
PASSWORD=$(date +%s%N)

#create a USER
useradd -c "${COMMENT}" -m $USER_NAME

#check if user is successfully created or not
if [[ $? -ne 0 ]]
then
  echo 'The Account could not be created'
  exit 1
fi


#set password for the user
echo $PASSWORD | passwd --stdin $USER_NAME

#check if password is successfully set or not
if [[ $? -ne 0 ]]
then
  echo "Password could not be set"
  exit 1
fi

#force password to chaneg at first log in

passwd -e $USER_NAME

#Display USERNAME ,PASSWORD AND HOSTNAME
echo
echo "Username: $USER_NAME"
echo
echo "Password: $PASSWORD"
echo
echo "$(hostname)"


