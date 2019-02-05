#!/bin/bash

### 50-m2-gulp.sh: this file runs the Snowdog Apps gulp commands
ls -alh "${BUILD_DIR}/"
if [ -f "${BUILD_DIR}/package.json" ]; then
    (cd "${BUILD_DIR}/" \
        && ls -alh \
        && yarn install \
        && yarn run prod \
    )
fi
