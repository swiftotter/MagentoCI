#!/bin/bash

### 10-composer.sh: this file installs the composer dependencies and the base Magento system

logvalue "Installing composer dependencies"

if [ -f "${CHECKOUT_DIR}/composer.json" ]; then
    cp ${CHECKOUT_DIR}/composer.* ${BUILD_DIR}
fi

if [ -f "${CHECKOUT_DIR}/src/composer.json" ]; then
    cp ${CHECKOUT_DIR}/src/composer.* ${BUILD_DIR}
fi

if [ -f "${BUILD_DIR}/composer.json" ]; then
    logvalue "Executing composer install"
    (cd ${BUILD_DIR} && composer install --ignore-platform-reqs --no-interaction --no-plugins --no-dev  --no-progress --no-suggest --prefer-dist) #--optimize-autoloader
    
    if [ $MAGENTO_VERSION == "1."* ]; then
        (cd ${BUILD_DIR} && composer run-script post-install-cmd -vvv -- --redeploy)
    fi
fi