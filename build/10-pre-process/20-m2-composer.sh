#!/bin/bash

### 10-composer.sh: this file installs the composer dependencies and the base Magento system

logvalue "Installing composer dependencies"

if [ -f "${CHECKOUT_DIR}/auth.json" ]; then
    cp ${CHECKOUT_DIR}/auth.* ${BUILD_DIR}
fi

if [ -f "${CHECKOUT_DIR}/composer.json" ]; then
    cp ${CHECKOUT_DIR}/composer.* ${BUILD_DIR}
fi

if [ -f "${CHECKOUT_DIR}/src/composer.json" ]; then
    cp ${CHECKOUT_DIR}/src/composer.* ${BUILD_DIR}
fi

if [ -d "${CHECKOUT_DIR}/patches" ]; then
    mkdir -p ${BUILD_DIR}/patches
    cp -r ${CHECKOUT_DIR}/patches/* ${BUILD_DIR}/patches
fi

ls -alh ${BUILD_DIR}

if [ -f "${BUILD_DIR}/composer.json" ]; then
    logvalue "Executing composer install"
    ADDITIONS=""
    if [[ ${TESTMODE} == 0 ]] || [[ -z ${TESTMODE+x} ]]; then
        ADDITIONS="--no-dev"
    fi
    COMPOSER_PATH="$(which composer)"
    (
     cd ${BUILD_DIR} && $PHP $COMPOSER_PATH install $ADDITIONS \
        --ignore-platform-reqs \
        --no-interaction \
        --no-progress \
        --no-suggest \
        --prefer-dist \
        --optimize-autoloader
    )
fi

ls -alh ${BUILD_DIR}
chmod -R 777 ${BASE}
