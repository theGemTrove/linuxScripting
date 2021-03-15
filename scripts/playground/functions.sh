#!/bin/bash
#
# This script will demonstrate the use of Fxns in base world
#
log() { # Code Runs To To Bottom.  Always Declare Fxns before Use.
  echo 'You called the log function!'
}

log

function logDeclaration {
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
    then
    echo 'Called From logDeclaration'
  fi
}

function logDeclarationWithLocalVerbose {
  local VERBOSE="${1}"
  shift
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
    then
    echo 'Called From logDeclaration'
  fi
  logger -t luser-fxn-demo.sh "${MESSAGE}"
}

logDeclaration 'Hello'
VERBOSE='true'
logDeclaration 'There'

readonly VERBOSITY='true'
logDeclarationWithLocalVerbose "${VERBOSITY}" "${MESSAGE}"

backup_file() {
  # This Fxn creates a backup of a file.  Returns non-zero status on error.

  local FILE="${1}"
  # Make sure the file exists.
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/temp/$(basename ${FILE}).$(date +%F-%N)"
    logDeclarationWithLocalVerbose "Backing up ${FILE} to ${BACKUP_FILE}"
    cp -p ${FILE} ${BACKUP_FILE}
  else
    return 1
  fi
}

backup_file "/etc/passwd"

if [[ "${?}" -eq '0']]
then
  logDeclarationWithLocalVerbose 'File Successfully Backed-up'
else
  then
    logDeclarationWithLocalVerbose 'File Failed To Back Up'
    exit 1
fi