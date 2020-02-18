#!/bin/bash

### 20-m2-update-database.sh: IF upgrades need to run, this enables maintenance mode and updates the database.


if [ -z ${OUTPUT_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

DB_STATUS=$( { cd ${RELEASE_DIR} && $PHP bin/magento setup:db:status; } 2>&1 )

logvalue "DB Status: ${DB_STATUS}"

if [[ $DB_STATUS = *"All modules are up to date."* ]] || [[ $MAGENTO_MISSING = 1 ]]; then
    logvalue "No DB upgrade needed."
    RUN_DB_UPGRADE=0
else
    logvalue "DB upgrade in process."
    RUN_DB_UPGRADE=1
fi

set -x

export RUN_DB_UPGRADE=$RUN_DB_UPGRADE

if [[ $RUN_DB_UPGRADE = 1 ]]; then
    logvalue "Maintenance mode and updating database."
    logvalue "Entering cd ${RELEASE_DIR}"

    (cd ${RELEASE_DIR} \
         && $PHP bin/magento maintenance:enable \
         && $PHP bin/magento setup:db-schema:upgrade \
         && $PHP bin/magento setup:db-data:upgrade \
    )
fi

if [[ $MAGENTO_MISSING = 0 ]]; then
    (cd ${RELEASE_DIR} && $PHP bin/magento cache:flush)
fi
