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
for FILE in `ls -d -- ${RELEASE_PARENT_DIR}/*-* | sort -t- -k2 -r`
do
    if [[ ! -d ${FILE} ]]; then
        continue
    fi
    if [[ ${FILE} != *"-${BUILD}"* ]]; then
        FILE_BASE=`basename ${FILE}`
        IFS='-' read -ra BUILD_ARR <<< "$FILE_BASE"
        BUILD_LABEL=${BUILD_ARR[0]}
        BUILD_NUM=${BUILD_ARR[1]}
        re='^[0-9]+$'
        if ! [[ $BUILD_NUM =~ $re ]]; then
            printf "${FILE_BASE} is not a build directory\n"
            continue
        fi
        if ! [[ "$BUILD_LABEL" = "build" ]]; then
            printf "${FILE_BASE} is not a build directory\n"
            continue
        fi
        let "NUM=NUM+1"
        if [[ $NUM > $PREVIOUS_BUILDS ]]; then
            printf "DELETING ${FILE}\n"
            rm -rf ${FILE}
        else
            printf "Keeping recent build ${BUILD_NUM}\n"
        fi
    else
        printf "Keeping current build ${BUILD}\n"
    fi
done

rm -rf ${RELEASE_PARENT_DIR}/*.gz
