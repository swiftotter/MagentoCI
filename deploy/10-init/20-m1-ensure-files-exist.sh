#!/bin/bash

### 20-m1-ensure-files-exist.sh: this file generates (or ensures that they exist) the folders and files necessary to run the site

if [ -z ${LINK_DIR+x} ] || [ -z ${RELEASE_DIR+x} ] || [ -z ${OUTPUT_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

if [ ! -f "${LINK_DIR}/local.xml" ]; then
    printf "You must have local.xml created!\n"
    exit 1
fi

if [ ! -d "${LINK_DIR}/media" ]; then
    printf "You must have /media created!\n"
    exit 1
fi