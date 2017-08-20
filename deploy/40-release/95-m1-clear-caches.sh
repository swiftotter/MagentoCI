#!/bin/bash

### 110-m1-clear-caches.sh: clearing all caches

if [ -d "${RELEASE_DIR}/vendor/n98/magerun" ]; then
    echo "Refreshing caches with n98 mage run"
    MAGERUN_CMD="${PHP} ${RELEASE_DIR}/vendor/n98/magerun/bin/n98-magerun"

    ${MAGERUN_CMD} cache:disable
    ${MAGERUN_CMD} cache:enable
    ${MAGERUN_CMD} cache:flush
fi
