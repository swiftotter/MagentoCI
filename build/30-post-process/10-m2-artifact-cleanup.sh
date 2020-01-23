#!/bin/bash

### 10-m2-artifact-cleanup.sh: this file cleans up files that are not needed or will conflict with permanent files on the server.

logvalue "Cleaning out unneeded M2 files"

if [ -f "${BUILD_DIR}/composer.json" ]; then
    logvalue "Updating autoloader"
    COMPOSER_PATH="$(which composer)"
    (cd ${BUILD_DIR} && $PHP $COMPOSER_PATH dump-autoload --optimize)
fi

rm -rf "${BUILD_DIR}/update"
rm -rf "${BUILD_DIR}/phpserver"
rm -rf "${BUILD_DIR}/index.php"
rm -rf "${BUILD_DIR}/app/etc/env.php"
rm -rf "${BUILD_DIR}/var/cache"
rm -rf "${BUILD_DIR}/var/session"
rm -rf "${BUILD_DIR}/var/log"
rm -rf "${BUILD_DIR}/var/page_cache"
rm -rf "${BUILD_DIR}/pub/media/"
