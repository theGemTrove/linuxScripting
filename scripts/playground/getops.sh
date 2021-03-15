#!/bin/bash

# This script generates a random password
# This user can set the password length with -l and add a special character with -s
# Verbose mode can be enabled with -v

# Set a default password length and verbose setting
VERBOSE='false'
PASSWORD_LENGTH=48

# Helper Fxns
usage() {
  echo 'Malformed Request. Please amend your query and try again.'
  echo "Usage: ${0} [-vs] [-l LENGTH]"
  echo 'Generate A Random Password.'
  echo ' -l   LENGTH  Specify a password length'
  echo ' -s           Append a special character to the password.'
  echo ' -v           Verbose Mode.'
  exit 1
}
sendToStdOUT() {
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

log() {
  local MESSAGE="${@}"
  echo "${MESSAGE}"
}

while getopts vl:s OPTION
do
  case ${OPTION} in
  v)
    VERBOSE='true'
    sendToStdOUT 'Verbose Mode on.'
    ;;
  l)
    if [[ "${OPTARG}" -lt 1 ]]
    then
      usage
    fi # Set Password.
    PASSWORD_LENGTH="${OPTARG}"
    sendToStdOUT "Password Length Set To ${PASSWORD_LENGTH} characters."
    ;;
  s)
    USE_SPECIAL_CHARACTER='true'
    ;;
  ?)
    usage
    ;;
  esac
done

# Remove the options while leaving the remaining arguments
shift "$(( OPTIND - 1 ))"

if [[ "${#}" -gt 0 ]]
then
  usage
fi

#Generate The Password
log 'Generating Password...'
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c ${PASSWORD_LENGTH}) &> /dev/null
if [[ "${?}" -ne 0 ]]
then
  usage
fi

# Append Special Character?
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
  sendToStdOUT 'Selecting Random Character To Append...'
  SPECIAL_CHARACTER=$(echo '!@#$%^&*()_+[]{}=' | fold -w 1 | shuf | head -c 1)
  NULLABLE_NUMBER=$(echo '0123456789' | fold -w 1 | shuf | head -c 1)
  PASSWORD=$(echo "${PASSWORD}" | sed "s/${NULLABLE_NUMBER}//")
  PASSWORD=$(echo "${PASSWORD}${SPECIAL_CHARACTER}" | fold -w 1 | shuf | tr -d '\n')
fi
log 'Password Generated was:'

# Log The Password To The Console
echo
log "${#PASSWORD}"
exit 0