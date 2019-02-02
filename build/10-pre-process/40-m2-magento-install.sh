#!/bin/bash

### 20-m1-build-test.sh: checks to ensure the build was successful.


logvalue "Installing Magento"

cd ${BUILD_DIR}



sudo chmod 777 .
sudo mkdir -p ${BUILD_DIR}/pub/media
sudo chmod -R 777 ${BUILD_DIR}/pub/media
sudo rm ${BUILD_DIR}/app/etc/env.php
sudo chmod +x bin/magento
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
