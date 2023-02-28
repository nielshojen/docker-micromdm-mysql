#!/bin/sh

sleep 5

execMdmctl="/usr/local/bin/mdmctl config switch"

if [[ ${MICROMDM_NAME} ]]; then
  execServe="${execServe} -name ${MICROMDM_NAME}"
else
  execServe="${execServe} -name production"
fi

echo "Switching config using: $execMdmctl"

$execMdmctl
