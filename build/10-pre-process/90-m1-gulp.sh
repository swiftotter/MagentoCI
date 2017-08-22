#!/bin/bash

### 90-gulp.sh: this file runs gulp commands on the build folder

if [[ ${TESTMODE} == 0 ]] || [[ -z ${TESTMODE+x} ]]; then
    if [[ -f "${CHECKOUT_DIR}/package.json" ]]; then
        (
            cd ${CHECKOUT_DIR} &&
        
            printf "Installing NPM modules" &&
            npm install &&

            printf "Gulping the files" &&
            npm run gulp prod
        )
    fi
fi
