#!/bin/bash

### 20-m1-build-test.sh: checks to ensure the build was successful.

if [[ ${THEME} != "null" ]] 
    && [[ ! -z ${var+x} ]] 
    && [[ ! -f ${BUILD_DIR}"/public/skin/frontend/${THEME}/*/css/*.css" ]]; then
    printf "No CSS files present for theme. Please investigate." 1>&2
    printf "BUILD ERROR" 1>&2
    exit 20
fi
