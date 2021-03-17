#!/bin/bash
#
#
#
#
# Helper Fxns
usage() {
  echo 'This script must be ran as root or with sudo' &>2
  echo
  echo 'Usage As Follows:'
  echo "./${0} <USER_ACCOUNT_LIST> [-dra]"
  echo
  echo 'Info: USER_ACCOUNT_LIST is space delimited for each account'
  echo 'd - Delete Account instead of Disabling'
  echo 'r - Remove the home directory associated with the account'
  echo 'a - Archive the home directory of the associated account to /archives'
  exit 1
}
handleScriptErrors() {
  local MESSAGE="${@}"
  echo
  echo "${MESSAGE}"
  echo
  usage
}

# Check For SuperUser Privileges
if [[ "${UID}" -ne 0 ]]
then
  handleScriptErrors
fi

# Print Usage If No Params Provided
if [[ "${#}" -lt 1 ]]
then
  handleScriptErrors
fi

# Set Default To Disable & Init Script Vars
DISABLE_ACCOUNT='true'

ARCHIVE_ACCOUNT='false'
DELETE_ACCOUNT='false'
REMOVE_DIRECTORY='false'

# Set Any Options
case
  a)
    ARCHIVE_ACCOUNT='true'
    ;;
  d)
    DISABLE_ACCOUNT='false'
    DELETE_ACCOUNT='true'
    ;;
  r)
    REMOVE_DIRECTORY='true'
    ;;
  *)
    handleScriptErrors 'A valid option must be supplied to this script.'
    ;;
esac

