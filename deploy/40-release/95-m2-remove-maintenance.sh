#!/bin/bash

### 110-m2-remove-maintenance.sh: this disables maintenance mode (if necessary)

if [ -z ${OUTPUT_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi


if [[ $RUN_DB_UPGRADE = 1 ]]; then
    logvalue "DISABLING maintenance mode."

    (cd ${OUTPUT_DIR} \
         && $PHP bin/magento maintenance:disable \
    )
fi
