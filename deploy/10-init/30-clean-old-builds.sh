#!/bin/bash

### 10-clear-old-builds.sh: this file cleans up previous releases

if [ -z ${BUILD+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

if [ -f "${BUILD_ID}.tar.gz" ]; then
    echo "Deleting build file"
    rm -f "${BUILD_ID}.tar.gz"
fi

PREVIOUS=`expr ${BUILD} - 1`
shopt -s nullglob
for FILE in ${RELEASE_PARENT_DIR}/*-*
do
    if [[ ${FILE} != *"-${BUILD}"* ]] && [[ ${FILE} != *"-${PREVIOUS}"* ]]; then
        printf "DELETING ${FILE}\n"
        rm -rf ${FILE}
    fi
done
shopt -u nullglob
