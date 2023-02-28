#!/bin/sh

set -e

chmod +x /docker-commands.d/*.sh
# sync prevents aufs from sometimes returning EBUSY if you exec right after a chmod
sync
for f in /docker-commands.d/*.sh; do
    echo "Running $f"
    "$f"
done
