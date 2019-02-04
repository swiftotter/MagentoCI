#!/bin/bash

### 50-m2-gulp.sh: this file runs the Snowdog Apps gulp commands

if [ -f "${BUILD_DIR}/package.json" ]; then
    (cd "${BUILD_DIR}/" \
        && ls -alh \
        && yarn install \
        && yarn run prod \
    )
fi
