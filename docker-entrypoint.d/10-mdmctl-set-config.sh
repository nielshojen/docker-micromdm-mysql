#!/bin/sh

sleep 5

execMdmctl="/usr/local/bin/mdmctl config set"

if [[ ${MICROMDM_API_KEY} ]]; then
  execMdmctl="${execServe} -api-token ${MICROMDM_API_KEY}"
else
  execMdmctl="${execServe} -api-token ${API_KEY}"
fi

if [[ ${MICROMDM_NAME} ]]; then
  execMdmctl="${execServe} -name ${MICROMDM_NAME}"
else
  execMdmctl="${execServe} -name production"
fi

if [[ ${MICROMDM_TLS} = true ]]; then
  execMdmctl="${execServe} -server-url https://localhost:443"
else
  execMdmctl="${execServe} -server-url http://localhost:8080"
fi

echo "Configuring mdmctl using: $execMdmctl"

$execMdmctl
