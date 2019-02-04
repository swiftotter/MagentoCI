#!/bin/bash

### 50-m2-gulp.sh: this file runs the Snowdog Apps gulp commands

if [ -f "${CHECKOUT_DIR}/package.json" ]; then
    (cd "${CHECKOUT_DIR}/" \
        && ls -alh \
        && yarn install \
        && yarn run prod \
    )
fi
