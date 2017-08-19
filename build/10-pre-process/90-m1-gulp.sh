#!/bin/bash

### 90-gulp.sh: this file runs gulp commands on the build folder

if [ ${TESTMODE} == 0 ] || [ -z ${TESTMODE+x} ]; then
    if [ -f "${BASE}/package.json" ]; then
        printf "Installing NPM modules"
        npm install

        printf "Gulping the files"
        npm run gulp prod
    fi
fi