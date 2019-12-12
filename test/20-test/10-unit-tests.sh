#!/bin/bash

### 10-local-xml.sh: This file sets up the variables needed for deployment

logvalue ${PHPUNIT_DIR}
logvalue ${CHECKOUT_DIR}/dev/tests/unit/phpunit.xml

if [ -d ${PHPUNIT_DIR} ] && [ -f ${CHECKOUT_DIR}/dev/tests/unit/phpunit.xml ]; then
    logvalue "Running PHPUNIT unit tests"
    ls -alh ${CHECKOUT_DIR}/dev/tests/unit/
    ${PHP} -dmemory_limit=512m ${PHPUNIT_BIN} --stderr --log-junit ${CHECKOUT_DIR}/phpunit-unit.xml --configuration ${CHECKOUT_DIR}/dev/tests/unit/phpunit.xml
fi

touch ${CHECKOUT_DIR}/phpunit-unit.xml
