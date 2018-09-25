#!/bin/bash

### 05-m1-patch-application.sh: this file applies patches located in the patch/ directory

if [[ -d "${CHECKOUT_DIR}/patch" ]]; then
    regex_flag="-regextype posix-extended"
    after_path=""
    processed=0

    if [ "$(uname)" == "Darwin" ]; then
        regex_flag=""
        after_path="-E"
    fi

    for file in `(cd ${CHECKOUT_DIR}/patch && ls) | sort -g -k1.15`; do
        printf "\nProcessing ${folder}\n"
        processed=1
        target_file="${BUILD_DIR}/public/${file}"

        cp "${CHECKOUT_DIR}/patch/$file" ${target_file}
        chmod 777 ${target_file}
        printf "\nApplying: ${file}\n"

        if [[ "$file" = *".patch" ]]; then
            echo "Applying patch: ${file}"
            (cd ${BUILD_DIR}/public/ && git apply ${file})
        else
            (cd ${BUILD_DIR}/public/ && sh ${file})
        fi

        #rm ${target_file}
    done

    if [ $processed == 0 ]; then
        printf "\nNo patches found in ${CHECKOUT_DIR}/patch"
    fi
fi


