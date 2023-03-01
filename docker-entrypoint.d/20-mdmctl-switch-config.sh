#!/bin/sh

sleep 5

execMdmctl="/usr/local/bin/mdmctl config switch"

if [[ ${MICROMDM_NAME} ]]; then
  execMdmctl="${execServe} -name ${MICROMDM_NAME}"
else
  execMdmctl="${execServe} -name production"
fi

echo "Switching config using: $execMdmctl"

$execMdmctl
