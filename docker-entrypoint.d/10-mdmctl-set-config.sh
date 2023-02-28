#!/bin/sh

sleep 5

execMdmctl="/usr/local/bin/mdmctl config set"

if [[ ${MICROMDM_API_KEY} ]]; then
  execServe="${execServe} -api-token ${MICROMDM_API_KEY}"
else
  execServe="${execServe} -api-token ${API_KEY}"
fi

if [[ ${MICROMDM_NAME} ]]; then
  execServe="${execServe} -name ${MICROMDM_NAME}"
else
  execServe="${execServe} -name production"
fi

if [[ ${MICROMDM_TLS} = true ]]; then
  execServe="${execServe} -server-url https://localhost:443"
else
  execServe="${execServe} -server-url http://localhost:8080"
fi

echo "Configuring mdmctl using: $execMdmctl"

$execMdmctl
