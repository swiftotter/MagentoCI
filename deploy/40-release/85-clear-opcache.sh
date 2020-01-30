#!/bin/bash

### 85-clear-opcache.sh: clears the opcache for PHP 7

## Cleaning PHP7 opcaches
if [[ -d "${RELEASE_DIR}/vendor/bin/cachetool" ]]; then
    logvalue "Clearing caches..."
    (cd ${RELEASE_DIR} && ${PHP} vendor/gordalina/cachetool/bin/cachetool opcache:reset)
fi

if [[ -f "/usr/share/stratus/cli" ]]; then
    logvalue "Clearing Stratus caches..."
    /usr/share/stratus/cli cache.all.clear
fi
