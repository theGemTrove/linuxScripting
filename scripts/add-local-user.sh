#!/bin/bash
#
# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges
if [[ "${UID}" -ne 0 ]]
then
  echo 'Please Run This Script As Root'
  exit 1
fi

# Get the username (login).
read -p 'Enter the username to create: ' USER_NAME

# Get Name (contents for the description field).
read -p 'Enter the name of the person or application that will be using this account: ' COMMENT

# Get the password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create Account
useradd -c "${COMMENT}" -m ${USER_NAME}
echo
## Create Command - Command Succeeded?
if [[ "${?}" -ne 0 ]]
then
  echo 'The account could not be created.'
  exit 1
fi

# Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Set Password - Command Succeeded?
if [[ "${?}" -ne 0 ]]
then
  echo 'The password could not be set'
  exit 1
fi

# First Login: Force Password Change
passwd -e ${USER_NAME}

# Display User Info
echo 'Username: '
echo "${USER_NAME}"
echo
echo 'Password: '
echo "${PASSWORD}"
echo
echo "Host:"
echo "${HOSTNAME}"