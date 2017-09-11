#!/bin/bash

### 10-m2-local-env.sh: This file sets up the variables needed for deployment

cp "${TEST_SCRIPT_DIR}/files/env.php" "${LOCAL_CONFIG}"
sed -i -e "s/--crypt-key--/${CRYPT_KEY}/g" "${LOCAL_CONFIG}"
sed -i -e "s/--table-prefix--/${TABLE_PREFIX}/g" "${LOCAL_CONFIG}"
sed -i -e "s/--username--/${MYSQL_USER}/g" "${LOCAL_CONFIG}"
sed -i -e "s/--password--/${MYSQL_PASSWORD}/g" "${LOCAL_CONFIG}"
sed -i -e "s/--database--/${MYSQL_DB_NAME}/g" "${LOCAL_CONFIG}"

TEST_CONFIG_FILE=${BUILD}/dev/tests/integration/etc/install-config-mysql.php
cp "${TEST_SCRIPT_DIR}/files/install-config-mysql.php" "${TEST_CONFIG_FILE}"
sed -i -e "s/--crypt-key--/${CRYPT_KEY}/g" "${TEST_CONFIG_FILE}"
sed -i -e "s/--table-prefix--/${TABLE_PREFIX}/g" "${TEST_CONFIG_FILE}"
sed -i -e "s/--username--/${MYSQL_USER}/g" "${TEST_CONFIG_FILE}"
sed -i -e "s/--password--/${MYSQL_PASSWORD}/g" "${TEST_CONFIG_FILE}"
sed -i -e "s/--database--/${MYSQL_DB_NAME}/g" "${TEST_CONFIG_FILE}"
