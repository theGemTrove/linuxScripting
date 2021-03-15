#!/bin/bash

# This script creates a new user on the system. The script must be run with superuser privileges.
# You must supply a username as the first argument of the script
# Optionally, you can also provide the ticket request number for the request in the comments field. [TRN-0000]
# Passwords will be automatically generated for the account.
# Finally, user account information will be printed to the console.

# Check for Superuser Status
if [[ "${UID}" -ne 0 ]]
then
  echo 'You must run this script with superuser privileges'
  exit 1
fi

# Check if the USER_NAME parameter was supplied with the command
if [[ "${#}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [COMMENT]"
  echo 'Please provide the USER_NAME parameter'
  exit 1
fi

# Extract USER_NAME from command
USER_NAME="${1}"

# Bundle other parameters into a comment
shift
COMMENT="${@}"

# Create the Account or Log Error
useradd -c "${COMMENT}" -m ${USERN_NAME}
if [[ "${?}" -ne 0 ]]
then
  echo 'Unable to create the account'
  echo 'Manually add the user, or, submit a ticket to the Sys-Admin Team'
  echo 'If you submit a ticket to the Sys-Admin Team, please allow 48 hours for ticket resolution.'
  echo 'If the Sys-Admin Team cannot meet the 48 hour deadline, you will receive a notification with a set deadline'
  exit 1
fi

# Automatically generate a password
PASSWORD=$(date %s%N  | sha256sum | head -c 48)

# Set the Password for the Account or Log Error
echo "${PASSWORD}" | passwd --stdin ${USER_NAME}
if [[ "${?}" -ne 0 ]]
then
  echo 'Unable to set the password for the account';
  echo 'Manually set the password, or, submit a ticket to the Sys-Admin Team'
  echo 'If you submit a ticket to the Sys-Admin Team, please allow 48 hours for ticket resolution.'
  echo 'If the Sys-Admin Team cannot meet the 48 hour deadline, you will receive a notification with a set deadline'
  exit 1
fi

# Force Password Change On First Login
passwd -e ${USER_NAME}

# Print Info To The Console
echo
echo 'Username: '
echo "${USER_NAME}"
echo
echo 'Password: '
echo "${PASSWORD}"
echo
echo 'Host: '
echo "${HOSTNAME}"
exit 0