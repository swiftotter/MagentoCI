#!/bin/bash

### 10-m1-update-database.sh: this runs the DB updates for Magento 1

if [ -z ${RELEASE_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

if [ -f "${RELEASE_DIR}/scripts/deploy/m1-db.php" ]; then
    echo "Updating database"
    php -f "${RELEASE_DIR}/scripts/deploy/m1-db.php"
fi