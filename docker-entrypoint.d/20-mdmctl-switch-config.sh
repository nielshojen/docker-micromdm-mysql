#!/bin/sh

sleep 5

execMdmctl="/usr/local/bin/mdmctl config switch"

if [[ ${MICROMDM_NAME} ]]; then
  execMdmctl="${execMdmctl} -name ${MICROMDM_NAME}"
else
  execMdmctl="${execMdmctl} -name production"
fi

echo "Switching config using: $execMdmctl"

$execMdmctl
