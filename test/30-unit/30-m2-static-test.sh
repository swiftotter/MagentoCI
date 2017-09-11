#!/bin/bash

### 10-local-xml.sh: This file sets up the variables needed for deployment

if [ -d ${PHPUNIT_DIR} ] && [ -f ${BUILD}/dev/tests/static/phpunit.xml ]; then
    (cd ${BUILD}/dev/tests/static && ${php} ${PHPUNIT_BIN} --stderr --log-junit ${OUTPUT_DIR}/phpunit-static.xml)
fi
