#!/bin/bash

### 20-m2-update-database.sh: IF upgrades need to run, this enables maintenance mode and updates the database.


if [ -z ${OUTPUT_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

DB_STATUS=$( { mage setup:db:status; } 2>&1 )

if [[ $DB_STATUS = *"All modules are up to date."* ]]; then
    RUN_DB_UPGRADE=1
else
    RUN_DB_UPGRADE=0
fi

export RUN_DB_UPGRADE=$RUN_DB_UPGRADE

if [[ $RUN_DB_UPGRADE = 1 ]]; then
    logvalue "Maintenance mode and updating database."

    (cd ${OUTPUT_DIR} \
         && $PHP bin/magento maintenance:enable \
         && $PHP bin/magento setup:db-schema:upgrade --keep-generated \
         && $PHP bin/magento setup:db-data:upgrade --keep-generated \
    )
fi

(cd ${OUTPUT_DIR} && $PHP bin/magento cache:flush)
