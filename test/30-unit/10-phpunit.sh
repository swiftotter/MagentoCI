#!/bin/bash

### 10-local-xml.sh: This file sets up the variables needed for deployment

if [ -d ${PHPUNIT_DIR} ]; then
    ${php} ${PHPUNIT_BIN} --configuration ${PHPUNIT_CONFIG_FILE} --stderr --log-junit ${OUTPUT_DIR}/phpunit.xml
fi