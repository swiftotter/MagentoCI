#!/bin/bash

### 10-local-xml.sh: This file sets up the variables needed for deployment

logvalue ${PHPUNIT_DIR}

if [ -d ${PHPUNIT_DIR} ] && [ -f ${BUILD}/dev/tests/integration/phpunit.xml ]; then
    (cd ${BUILD}/dev/tests/integration && ${php} ${PHPUNIT_BIN} --stderr --log-junit ${OUTPUT_DIR}/phpunit.xml)
fi
