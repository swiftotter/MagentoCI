#!/bin/bash

### 10-local-xml.sh: This file sets up the variables needed for deployment

logvalue ${PHPUNIT_DIR}

if [ -d ${PHPUNIT_DIR} ]; then
    (cd ${BUILD} && ${php} ${PHPUNIT_BIN} --stderr --log-junit ${OUTPUT_DIR}/phpunit.xml)
fi
