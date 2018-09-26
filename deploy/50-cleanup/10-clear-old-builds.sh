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
shopt -s nullglob
for FILE in ${RELEASE_PARENT_DIR}/*-*
do
    if [[ ! -d ${FILE} ]]; then
        continue
    fi
    if [[ ${FILE} != *"-${BUILD}"* ]]; then
        let "NUM=NUM+1"
        IFS='-' read -ra BUILD_ARR <<< "$FILE"
        BUILD_NUM=${BUILD_ARR[@]:(-1)}
        re='^[0-9]+$'
        if ! [[ $BUILD_NUM =~ $re ]] ; then
            printf "${BUILD_NUM} is not numeric\n"
            #continue
        fi
        if [[ $NUM > $PREVIOUS_BUILDS ]]; then
            printf "DELETING ${FILE}\n"
            #rm -rf ${FILE}
        else
            printf "Keeping recent build ${BUILD_NUM}\n"
        fi
    else
        printf "Keeping current build ${BUILD}\n"
    fi
done
