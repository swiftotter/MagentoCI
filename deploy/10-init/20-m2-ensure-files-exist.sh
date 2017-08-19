#!/bin/bash

### 20-m2-ensure-files-exist.sh: this file ensures that the proper system pre-requisites are in place before proceeding

if [ -z ${LINK_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

if [ ! -f "${LINK_DIR}/env.php" ]; then
    printf "Magento's env.php is not found in ${LINK_DIR}. Please create it."
    exit 1
fi

if [ ! -d "${LINK_DIR}/media" ]; then
    mkdir -p "${LINK_DIR}/media"
fi

if [ ! -d "${LINK_DIR}/var/cache" ]; then
    mkdir -p "${LINK_DIR}/var/cache"
fi

if [ ! -d "${LINK_DIR}/var/log" ]; then
    mkdir -p "${LINK_DIR}/var/log"
fi