#!/bin/bash

### 20-m2-ensure-files-exist.sh: this file ensures that the proper system pre-requisites are in place before proceeding

if [ -z ${LINK_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

export MAGENTO_MISSING=0;

if [ ! -f "${LINK_DIR}/env.php" ]; then
    echo "Magento's env.php is not found in ${LINK_DIR}. Please install Magento.\n"
    echo "cd ${OUTPUT_DIR} && php bin/magento setup:install --db-host=localhost --db-name=SPECIFY_DB_NAME \ \n"
    echo "                    --db-user=SPECIFY_DB_USER --db-password=SPECIFY_DB_PASSWORD \ \n"
    echo "                    --admin-firstname=Magento --admin-lastname=User --admin-email=YOUR_EMAIL@YOU.com \ \n"
    echo "                    --admin-user=site-admin --admin-password=PASSWORD321 --language=en_US \ \n"
    echo "                    --currency=USD --use-rewrites=1"
    
    touch "${LINK_DIR}/env.php"
    
    export MAGENTO_MISSING=1;
fi

if [ ! -d "${LINK_DIR}/media" ]; then
    mkdir -p "${LINK_DIR}/media"
fi

if [ ! -d "${LINK_DIR}/var/cache" ]; then
    mkdir -p "${LINK_DIR}/var/cache"
fi

if [ ! -d "${LINK_DIR}/var/log" ]; then
    mkdir -p "${LINK_DIR}/var/log"
fi
