#!/bin/bash

### 50-m2-gulp.sh: this file runs the Snowdog Apps gulp commands

if [ -f "${CHECKOUT_DIR}/package.json" ]; then
    (cd "${BUILD_DIR}/"  \
        && npm install \
        && npm run prod \
    )
fi


if [ ! -z "$THEME" -a "$THEME" != " " ]; then

    (cd "${BUILD_DIR}/vendor/snowdog/frontools/"  \
        && npm install \
        && gulp inheritance --prod --theme ${THEME} --gulpfile gulpfile.js \
        && gulp babel --prod --theme ${THEME} --gulpfile gulpfile.js \
        && gulp styles --prod --disableMaps --theme ${THEME} --gulpfile gulpfile.js \
    )

fi
