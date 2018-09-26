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

NUM=0
PREVIOUS_BUILDS=2

for FILE in `ls -d -- ${RELEASE_PARENT_DIR}/*-* | sort -t- -k2 -r`
do
    if [[ ${FILE} != *"-${BUILD}"* ]]; then
        let "NUM=NUM+1"
        if [[ $NUM > $PREVIOUS_BUILDS ]]; then
            printf "DELETING ${FILE}\n"
            #rm -rf ${FILE}
        else
            IFS='-' read -ra BUILD_ARR <<< "$FILE"
            printf "Keeping recent build ${BUILD_ARR[1]}\n"
        fi
    else
        printf "Keeping current build ${BUILD}\n"
    fi
done
