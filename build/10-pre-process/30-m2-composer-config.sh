#!/bin/bash

### 30-m2-composer-config.sh: this file ensures all Magento 2 root files are present.

logvalue "Installing composer dependencies"

## For some reason, composer doesn't always copy out the files in the magento2 base folder. This ensures those are present. 

if [[ ! -d "${BUILD_DIR}/lib" ]] && [[ -d "${BUILD_DIR}/vendor/magento/magento2-base" ]]; then
    cp -r ${BUILD_DIR}/vendor/magento/magento2-base/* ${BUILD_DIR}
fi

if [[ ! -d "${BUILD_DIR}/app/etc/enterprise/di.xml" ]] && [[ -d "${BUILD_DIR}/vendor/magento/magento2-ee-base" ]]; then
    cp -r ${BUILD_DIR}/vendor/magento/magento2-ee-base/* ${BUILD_DIR}
fi

if [[ ! -f "${BUILD_DIR}/app/etc/vendor_path.php" ]]; then
    echo "<?php return './vendor';" > ${BUILD_DIR}/app/etc/vendor_path.php
fi
