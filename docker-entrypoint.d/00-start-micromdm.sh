#!/bin/sh

echo "Waiting to make sure storage is up"

execServe="/usr/local/bin/micromdm serve -server-url=${MICROMDM_SERVER_URL}"

# filerepo
if [[ ! ${MICROMDM_FILE_REPO} ]]; then
  execServe="${execServe} -filerepo /repo"
fi

# add api key if specified
if [[ ${API_KEY} ]]; then
  execServe="${execServe} -api-key ${API_KEY}"
fi

# set TLS
if [[ ${TLS} = true ]]; then
  execServe="${execServe} -tls"
else
  execServe="${execServe} -tls=false"
fi

if [[ ${TLS_CERT} ]] && [[ ${TLS_KEY} ]]; then
  execServe="${execServe} -tls-cert '${TLS_CERT}' -tls-key '${TLS_KEY}'"
fi

# set HTML
if [[ "${HOMEPAGE}" = "false" ]]; then
  execServe="${execServe} -homepage=false"
fi

# set webhook
if [[ ${WEBHOOK_URL} ]]; then
  execServe="${execServe} -command-webhook-url ${WEBHOOK_URL}"
fi

#set debug
if [[ ${DEBUG} ]]; then
  execServe="${execServe} -http-debug"
fi

echo "Starting using: $execServe"

$execServe &
