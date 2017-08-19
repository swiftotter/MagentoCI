#!/bin/bash

### 50-m2-gulp.sh: this file runs the Snowdog Apps gulp commands

if [ ! -z "$THEME" -a "$THEME" != " " ]; then

    (cd "${BUILD_DIR}/vendor/snowdog/frontools/"  \
        && npm install \
        && gulp inheritance --prod --theme flow --gulpfile gulpfile.js \
        && gulp babel --prod --theme flow --gulpfile gulpfile.js \
        && gulp styles --prod --disableMaps --theme flow --gulpfile gulpfile.js \
    )

fi