#!/bin/bash

### 20-cleanup.sh: this file cleans up the build location

logvalue "Deleting previous build folders and files"

if [[ ${TESTMODE} == 0 ]] || [[ -z ${TESTMODE+x} ]]; then
    rm -f *.tar.gz
    rm -rf "${BUILD_DIR}"
    mkdir -p "${BUILD_DIR}"
fi