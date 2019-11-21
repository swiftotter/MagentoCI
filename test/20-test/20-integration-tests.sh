#!/bin/bash

### 10-local-xml.sh: This file sets up the variables needed for deployment

logvalue ${PHPUNIT_DIR}
logvalue ${CHECKOUT_DIR}/dev/tests/integration/phpunit.xml

if [ -d ${PHPUNIT_DIR} ] && [ -f ${CHECKOUT_DIR}/dev/tests/integration/phpunit.xml ]; then
    logvalue "Running PHPUNIT integration tests"
    rm ${CHECKOUT_DIR}/dev/tests/integration/files/install-config-mysql.php
    cp ${CHECKOUT_DIR}/dev/tests/integration/files/install-config-mysql.php.dist ${CHECKOUT_DIR}/dev/tests/integration/files/install-config-mysql.php

    sed -i "s/'db-host' => 'localhost'/'db-host' => '${MYSQL_HOST}'/g" ${CHECKOUT_DIR}/dev/tests/integration/files/install-config-mysql.php
    sed -i "s/'db-user' => 'root'/'db-user' => 'login-user'/g" ${CHECKOUT_DIR}/dev/tests/integration/files/install-config-mysql.php
    sed -i "s/'db-password' => '123123q'/'db-password' => 'very-secret-password'/g" ${CHECKOUT_DIR}/dev/tests/integration/files/install-config-mysql.php
    sed -i "s/'db-name' => 'magento_integration_tests'/'db-name' => 'build_db'/g" ${CHECKOUT_DIR}/dev/tests/integration/files/install-config-mysql.php

    ls -alh ${CHECKOUT_DIR}/dev/tests/integration/
    cat ${CHECKOUT_DIR}/dev/tests/integration/files/install-config-mysql.php

    ${PHP} -dmemory_limit=512m ${PHPUNIT_BIN} --stderr --log-junit ${CHECKOUT_DIR}/phpunit-integration.xml --configuration ${CHECKOUT_DIR}/dev/tests/integration/phpunit.xml
fi
