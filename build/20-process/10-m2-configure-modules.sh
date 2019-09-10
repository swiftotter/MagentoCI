#!/bin/bash

### 10-m2-configure-modules.sh: runs the module installers / uninstaller commands.

logvalue "Executing module installers"

if [ -f "${CHECKOUT_DIR}/app/etc/config.php" ]; then
    logvalue "config.php found, using that to configure installed modules."
    
    mkdir -p ${BUILD_DIR}/app/etc
    cp ${CHECKOUT_DIR}/app/etc/config.php ${BUILD_DIR}/app/etc/config.php
    $MAGENTO_CMD app:config:import --no-interaction
else
    fileiterator "${SCRIPT_BUILD_DIR}/module-installer" ${BUILD_DIR}
fi

