#!/bin/sh

sleep 5

execMdmctl="/usr/local/bin/mdmctl config set"

if [[ ${MICROMDM_API_KEY} ]]; then
  execMdmctl="${execMdmctl} -api-token ${MICROMDM_API_KEY}"
else
  execMdmctl="${execMdmctl} -api-token ${API_KEY}"
fi

if [[ ${MICROMDM_NAME} ]]; then
  execMdmctl="${execMdmctl} -name ${MICROMDM_NAME}"
else
  execMdmctl="${execMdmctl} -name production"
fi

if [[ ${MICROMDM_TLS} = true ]]; then
  execMdmctl="${execMdmctl} -server-url https://localhost:443"
else
  execMdmctl="${execMdmctl} -server-url http://localhost:8080"
fi

echo "Configuring mdmctl using: $execMdmctl"

$execMdmctl
