#!/bin/bash

### 20-m2-composer.sh: this file installs the composer dependencies and the base Magento system

logvalue "Installing composer dependencies"
base=$(pwd)
base=${base%/}
export BASE=$base

## Code directories
export CHECKOUT_DIR="${base}"

export PHPUNIT_DIR="${CHECKOUT_DIR}/vendor/phpunit/phpunit"
export PHPUNIT_BIN="${PHPUNIT_DIR}/phpunit"

if [ ${#MAGENTO_USERNAME} -ge 5 ]; then
  composer config -a -g http-basic.repo.magento.com ${MAGENTO_USERNAME} ${MAGENTO_PASSWORD}
fi

if [ -f "${CHECKOUT_DIR}/composer.json" ]; then
    logvalue "Executing composer install"
    ADDITIONS=""
    if [[ ${TESTMODE} == 0 ]] || [[ -z ${TESTMODE+x} ]]; then
        ADDITIONS="--no-dev"
    fi
    COMPOSER_PATH="$(which composer)"
    (cd ${CHECKOUT_DIR} && $PHP $COMPOSER_PATH install $ADDITIONS --ignore-platform-reqs --no-interaction --no-plugins --no-progress --no-suggest --prefer-dist --optimize-autoloader)
fi

if [[ ! -d "${CHECKOUT_DIR}/lib" ]] && [[ -d "${CHECKOUT_DIR}/vendor/magento/magento2-base" ]]; then
    cp -r ${CHECKOUT_DIR}/vendor/magento/magento2-base/* ${CHECKOUT_DIR}
fi

if [[ ! -d "${CHECKOUT_DIR}/app/etc/enterprise/di.xml" ]] && [[ -d "${CHECKOUT_DIR}/vendor/magento/magento2-ee-base" ]]; then
    cp -r ${CHECKOUT_DIR}/vendor/magento/magento2-ee-base/* ${CHECKOUT_DIR}
fi

if [[ ! -f "${CHECKOUT_DIR}/app/etc/vendor_path.php" ]]; then
    echo "<?php return './vendor';" > ${CHECKOUT_DIR}/app/etc/vendor_path.php
fi

ls -alh ${CHECKOUT_DIR}
chmod -R 777 ${BASE}
