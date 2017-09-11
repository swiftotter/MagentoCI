#!/bin/bash

### 10-local-xml.sh: This file sets up the variables needed for deployment

if [ -d ${PHPUNIT_DIR} ] && [ -f ${BUILD}/dev/tests/unit/phpunit.xml ]; then
    (cd ${BUILD}/dev/tests/unit && ${php} ${PHPUNIT_BIN} --stderr --log-junit ${OUTPUT_DIR}/phpunit-unit.xml)
fi
