#!/bin/bash

### 20-m2-merge.sh: runs the compile commands on a Magento 2 project.

cd ${BUILD_DIR}

touch "${BUILD_DIR}/pub/static/deployed_version.txt"

mysql -u root ${MYSQL_PASSWORD_PROMPT} ${DB_NAME} <<-EOSQL
  INSERT INTO core_config_data (config_id, scope, scope_id, path, value) VALUES (null, 'default', 0, 'dev/css/minify_files', '1');
EOSQL

$MAGENTO_CMD deploy:mode:set production --skip-compilation
$MAGENTO_CMD setup:upgrade
$MAGENTO_CMD setup:di:compile
$MAGENTO_CMD setup:static-content:deploy
