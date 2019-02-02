#!/bin/bash

### 20-m1-build-test.sh: checks to ensure the build was successful.


logvalue "Installing Magento"

cd ${BUILD_DIR}

chmod 777 .
mkdir -p ${BUILD_DIR}/pub/media
chmod -R 777 ${BUILD_DIR}/pub/media
rm ${BUILD_DIR}/app/etc/env.php
chmod +x bin/magento
${MAGENTO_CMD} setup:install \
    --admin-firstname="Magento" \
    --admin-lastname="Builder" \
    --admin-email="joseph@swiftotter.com" \
    --admin-user="${MAGE_ADMIN_USER}" \
    --admin-password="${MAGE_ADMIN_PASSWORD}" \
    --db-name="mysql_database" \
    --db-user="root" \
    --db-password="mysql_strong_password" \
    --db-host="mysql"
