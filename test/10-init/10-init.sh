#!/bin/bash

### 0-init.sh: This file sets up the variables needed for deployment

BASE=${PWD%/}

export BASE=${BASE}
export BUILD="${BASE}/build"
export VENDOR="${BUILD}/vendor"
export OUTPUT_DIR="${BASE}/output"
export SCRIPT_DIR="${BASE}/scripts"
export TEST_SCRIPT_DIR="${BASE}/scripts/test/"
export PHPUNIT_CONFIG_FILE="${BUILD}/phpunit.xml"
export PHPUNIT_DIR="${BASE}/vendor/phpunit/phpunit"
export PHPUNIT_BIN="${PHPUNIT_DIR}/phpunit"
export DOMAIN=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
export HOST="http://${DOMAIN}/"

if [[ ! -f ${BUILD}/phpunit.xml ]]; then
    logvalue "No phpunit.xml found. Cancelling."
    exit 125
fi


mkdir -p ${OUTPUT_DIR}

if [ -z ${MYSQL_USER+x} ]; then
    export MYSQL_USER="root"
fi

if [ -z ${MYSQL_PASSWORD+x} ]; then
    export MYSQL_PASSWORD=""
fi

export MYSQL_DB_NAME="db_"$(date +%s | sha256sum | base64 | head -c 7)

echo "LOCAL XML: ${LOCAL_XML}\n"
echo "MYSQL:\n"
echo " - DB: "${MYSQL_DB_NAME}
echo " - USER: "${MYSQL_USER}
echo " - PASSWORD: "${MYSQL_PASSWORD}

mysql_execute() {
    mysql --user=${MYSQL_USER} --password=${MYSQL_PASSWORD} --database=${MYSQL_DB_NAME} --execute="${1}"
}