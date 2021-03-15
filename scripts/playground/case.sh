#!/bin/bash
#
# This Script Demonstrates the use of case

 Using An If Statement
if [[ "${1}" = 'start']]
then
 echo 'Starting From If...'
elif [[ "${1}" = 'status' ]]
then
 echo 'Status...'
elif [["${1}" = 'stop']]
then
  echo 'Stopping From If...'
else
  echo 'From If: Please Provide A Valid Option'
fi

# Using A Case Statement
case "${1}" in # Verbose Form
  start)
    echo 'Starting From Case'
  ;;
  state|status|--state|--status)
    echo 'Fetching Status From Case'
  ;;
  stop)
    echo 'Stopping'
  ;;
  *)
    echo 'From Case: Please Provide A Valid Option' >&2
    exit 1
  ;;
esac

case "${1}" in # Compact Form
  start) echo 'Starting From Case' ;;
  state) echo 'Fetching Status From Case' ;;
  stop)  echo 'Stopping' ;;
  *)
    echo 'From Case: Please Provide A Valid Option' >&2
    exit 1 ;;
esac