#!/bin/bash

### 15-m2-init.sh: this file initializes additional variable for Magento 2

logvalue "Initializing M2 variables"
logvalue "Magento version: ${MAGENTO_VERSION}"

if [[ $MAGENTO_VERSION == "2."* ]]; then
    ## Composer vendor directory
    export MAGENTO_CMD="php -dmemory_limit=1500M bin/magento"

    export MODULE_INSTALLER="${base}/scripts/build/module-installer"

    export DB_NAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 10 ; echo '')
    export MAGE_ADMIN_USER=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 10 ; echo '')
    export MAGE_ADMIN_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 10 ; echo '')"123"
    
    if [ -z "${MYSQL_USER+x}" ]; then
        export MYSQL_USER="root"
    fi

    if [ -n "${MYSQL_PASSWORD+x}" ]; then
        export MYSQL_PASSWORD_PROMPT=--password="${MYSQL_PASSWORD}"
    else
        export MYSQL_PASSWORD_PROMPT=""
    fi

    logvalue "DB Name: ${DB_NAME}"
    logvalue "Magento Admin User: ${MAGE_ADMIN_USER}"
    logvalue "Magento Admin Password: ${MAGE_ADMIN_PASSWORD}"
fi